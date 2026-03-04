SMODS.DrawStep {
    key = "third_pos",
    order = 100,
    func = function(self)
        if self.config.center.third_pos and (self.config.center.discovered or self.bypass_discovery_center) then
            if not self.children.third_pos then
                local center = self.config.center
                local atlas_key = center[G.SETTINGS.colourblind_option and "hc_atlas" or "lc_atlas"] or center.atlas or center.set
                self.children.third_pos = SMODS.create_sprite(self.T.x, self.T.y, self.T.w, self.T.h, atlas_key, center.third_pos)
                self.children.third_pos.role.draw_major = self
                self.children.third_pos.states.hover.can = false
                self.children.third_pos.states.click.can = false
            end

            local time = G.TIMERS.REAL + (math.pi / 2)
            local dampen = 0.6
            local scale_mod = 0.07 + 0.02 * math.sin(1.8 * time) + 0.00 * math.sin((time - math.floor(time)) * math.pi * 14) * (1 - (time - math.floor(time))) ^ 3
            local rotate_mod = 0.05 * math.sin(1.219 * time) + 0.00 * math.sin(time * math.pi * 5) * (1 - (time - math.floor(time))) ^ 2

            scale_mod = scale_mod * dampen
            rotate_mod = rotate_mod * dampen

            if type(self.config.center.soul_pos.draw) == "function" then
                self.config.center.soul_pos.draw(self, scale_mod, rotate_mod)
            elseif self.children.third_pos then
                self.children.third_pos:draw_shader("dissolve", 0, nil, nil, self.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * time), nil, 0.6)
                self.children.third_pos:draw_shader("dissolve", nil, nil, nil, self.children.center, scale_mod, rotate_mod)
            end
        end
    end,
    conditions = { vortex = false, facing = "front" },
}

SMODS.draw_ignore_keys["third_pos"] = true

SMODS.Rarity {
    key = "exquisite",
    badge_colour = SMODS.Gradient {
        key = "exquisite_gradient",
        colours = {
            HEX("0030CF"),
            HEX("FF90E3"),
            HEX("94D8FF"),
        },
        cycle = 5,
        interpolation = "trig",
    },
}

SMODS.Joker {
    key = "madstone_whiskey",
    atlas = "float",
    pos = { x = 7, y = 4 },
    soul_pos = { x = 8, y = 4 },
    third_pos = { x = 9, y = 4 },
    config = { extra = { gain = 1, xmult = 1 } },
    rarity = "valk_exquisite",
    cost = 50,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        if context.using_consumeable and context.consumeable.config.center_key == "c_fool" then
            add_tag(Tag("tag_charm"))
            SMODS.add_card { set = "Tarot", area = G.consumeables }
        end

        if context.selling_card and context.card.config.center.set == "Tarot" then
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "gain" })
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    valk_artist = "pangaea",
}

SMODS.Joker {
    key = "astracola",
    atlas = "float",
    pos = { x = 0, y = 5 },
    soul_pos = { x = 2, y = 5 },
    third_pos = { x = 1, y = 5 },
    config = { extra = { levels = 2, levels_gain = 1 } },
    rarity = "valk_exquisite",
    cost = 50,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.levels, card.ability.extra.levels_gain } }
    end,
    calculate = function(self, card, context)
        -- code here

        if context.selling_card and context.card.config.center.set == "Planet" then
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "levels", scalar_value = "levels_gain" })
        end

        if context.using_consumeable and context.consumeable.config.center.set == "Planet" then
            local hand = Valk.util.poll_hand("valk_astracola", true)
            SMODS.upgrade_poker_hands { hands = { hand }, level_up = card.ability.extra.levels, from = card }
        end
    end,
    valk_artist = "pangaea",
}
