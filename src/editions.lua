SMODS.Shader {
    key = "cosmic",
    path = "cosmic.fs",
    send_vars = function(self, sprite, card)
        return {
            screen_size = { love.graphics.getWidth(), love.graphics.getHeight() },
        }
    end,
}

SMODS.Shader {
    key = "glow",
    path = "glow.fs",
}

SMODS.Shader {
    key = "rgb",
    path = "rgb.fs",
}

SMODS.Edition {
    key = "cosmic",
    shader = "cosmic",
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                echips = card.edition.echips,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.echips } }
    end,
    config = { echips = 1.05 },
    extra_cost = 3,
    weight = 5,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
    in_shop = true,
    sound = { sound = "spawn_cosmic" },
}

SMODS.Edition {
    key = "rgb",
    shader = "rgb",
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = card.edition.chips,
                xmult = card.edition.xmult,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips, card.edition.xmult } }
    end,
    config = { chips = 25, xmult = 1.25 },
    extra_cost = 3,
    weight = 8,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
    in_shop = true,
    sound = { sound = "spawn_rgb" },
}

SMODS.Edition {
    key = "glow",
    shader = "glow",
    calculate = function(self, card, context)
        if (context.post_trigger and context.other_card == card) or (context.main_scoring and context.cardarea == G.play) then
            card:juice_up()
            local sets = { "Planet", "Tarot" }
            if next(SMODS.find_card("j_valk_arkade")) then
                table.insert(sets, "Spectral")
            end
            local chosen = Valk.util.poll_sets(sets, "valk_glowdark")
            SMODS.add_card { key = chosen, area = G.consumeables }
        end
    end,
    extra_cost = 12,
    weight = 4,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
    in_shop = true,
    sound = { sound = "spawn_glow" },
}

SMODS.Edition {
    key = "censored",
    shader = false,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
    calculate = function(self, card, context)
        if context.other_card == card and ((context.repetition and context.cardarea == G.play) or (context.retrigger_joker_check and not context.retrigger_joker)) then
            return {
                repetitions = 2,
            }
        end
    end,
    get_weight = function(self)
        return G.GAME.edition_rate * self.weight
    end,
    weight = 1,
    in_shop = true,
    sound = { sound = "spawn_censored" },
}

Valk.util.hook_after("SMODS.injectItems", function()
    for _, center in pairs(G.P_CENTERS) do
        if center.loc_vars then
            Valk.util.ref_hook(center, "loc_vars", function(original, cen, iq, card)
                local res = original(cen, iq, card)
                if Spectrallib.safe_get(card, "edition", "key") == "e_valk_censored" then
                    res = res or {}
                    res.vars = res.vars or {}
                    for i, _ in ipairs(res.vars) do
                        res.vars[i] = "???"
                    end
                end
                return res
            end)
        end
    end
end)

SMODS.draw_ignore_keys["censor"] = true
SMODS.DrawStep {
    key = "censorship",
    func = function(card, layer)
        local censor = (card.edition and card.edition.key == "e_valk_censored")
        local allowed = layer == "both" or layer == "card"
        if censor and allowed then
            if not card.children.censor then
                card.children.censor = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["valk_edition_assets"], { x = 0, y = 0 })
                card.children.censor.role.draw_major = card
                card.children.censor.states.hover.can = false
                card.children.censor.states.click.can = false
            end

            card.children.center.VT.r = 0 --doesn't affect base card due to draw order
            card.children.censor:draw_shader("dissolve", nil, nil, true, card.children.center, card.config.center.valk_censor_scale or 0, 0)
        else
            if card.children.censor then
                card.children.censor:remove()
            end
            card.children.censor = nil
        end
    end,
    order = 99,
}

SMODS.Edition {
    key = "lordly",
    shader = false,
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                emult = 1 + (card.edition.emult * #G.jokers.cards),
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        local cards = G.jokers and #G.jokers.cards or 0
        return { vars = { card.edition.emult, 1 + (card.edition.emult * cards) } }
    end,
    config = { emult = 0.2 },
    extra_cost = 9,
    weight = 1,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
    in_shop = true,
    sound = { sound = "spawn_lordly" },
}

SMODS.draw_ignore_keys["halo"] = true

SMODS.DrawStep {
    key = "lordly",
    func = function(card, layer)
        local draw_halo = (card.edition and card.edition.key == "e_valk_lordly")
        local allowed = layer == "both" or layer == "card"
        if draw_halo and allowed then
            if not card.children.halo then
                card.children.halo = Sprite(card.T.x, card.T.y, card.T.w, card.T.h, G.ASSET_ATLAS["valk_edition_assets"], { x = 1, y = 0 })
                card.children.halo.role.draw_major = card
                card.children.halo.states.hover.can = false
                card.children.halo.states.click.can = false
            end

            local scale_mod = 0.07 + 0.02 * math.sin(1.8 * G.TIMERS.REAL) + 0.00 * math.sin((G.TIMERS.REAL - math.floor(G.TIMERS.REAL)) * math.pi * 14) * (1 - (G.TIMERS.REAL - math.floor(G.TIMERS.REAL))) ^ 3

            local etimer = G.TIMERS.REAL * 2
            local rotate_mod = 0.05 * math.sin(1.219 * etimer) + 0.00 * math.sin(etimer * math.pi * 5) * (1 - (etimer - math.floor(etimer))) ^ 2

            scale_mod = scale_mod * 1.15

            card.children.center.VT.r = 0
            card.children.halo:draw_shader("dissolve", 0, nil, nil, card.children.center, scale_mod, rotate_mod, nil, 0.1 + 0.03 * math.sin(1.8 * G.TIMERS.REAL), nil, 0.6)
            card.children.halo:draw_shader("dissolve", nil, nil, nil, card.children.center, scale_mod, rotate_mod)
        else
            card.children.halo = nil
        end
    end,
    order = 992999,
}
