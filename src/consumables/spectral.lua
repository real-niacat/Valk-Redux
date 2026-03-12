SMODS.Consumable {
    key = "soteria",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 0, y = 3 },
    can_use = function(self, card)
        return true
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.change_play_limit(card.ability.extra.cards)
                SMODS.change_discard_limit(card.ability.extra.cards)
                attention_text {
                    cover = G.hand,
                    cover_colour = G.C.FILTER,
                    colour = G.C.UI.TEXT_LIGHT,
                    text = localize { type = "variable", key = "k_plus_sel_limit", vars = { card.ability.extra.cards } },
                    hold = 2,
                }
                G.GAME.blind_size_multiplier = G.GAME.blind_size_multiplier + card.ability.extra.bsize
                card:juice_up(0.3, 0.5)
                return true
            end,
        })
        delay(0.6)
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, card.ability.extra.bsize * 100 } }
    end,
    config = {
        extra = {
            cards = 2,
            bsize = 0.2, --20%
        },
    },
    valk_artist = "mailingway",
}

SMODS.Consumable {
    key = "thilykotita",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 2, y = 3 },
    can_use = function(self, card)
        return #G.hand.cards > 0 and #Valk.util.get_matching(G.hand.cards, function(e)
            return e:get_id() ~= 12
        end) > 0
    end,
    use = function(self, card, area, copier)
        local available = Valk.util.get_matching(G.hand.cards, function(e)
            return e:get_id() ~= 12
        end)

        local chosen = {}
        for i = 1, math.min(card.ability.extra.cards, #available) do
            local chosen_index = pseudorandom("valk_fem", 1, #available)
            table.insert(chosen, available[chosen_index])
            table.remove(available, chosen_index)
        end

        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                for _, c in pairs(chosen) do
                    c:flip()
                end
                return true
            end,
        })
        delay(2)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                play_sound("tarot1")
                for _, c in pairs(chosen) do
                    SMODS.change_base(c, nil, "Queen")
                    c:juice_up()
                end
                return true
            end,
        })
        delay(2)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                for _, c in pairs(chosen) do
                    c:flip()
                end
                return true
            end,
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = {
        cards = 3,
    } },
    valk_artist = "mailingway",
}

SMODS.Consumable {
    key = "andrisimos",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 3, y = 3 },
    can_use = function(self, card)
        return #G.hand.cards > 0 and #Valk.util.get_matching(G.hand.cards, function(e)
            return e:get_id() ~= 11
        end) > 0
    end,
    use = function(self, card, area, copier)
        local available = Valk.util.get_matching(G.hand.cards, function(e)
            return e:get_id() ~= 11
        end)

        local chosen = {}
        for i = 1, math.min(card.ability.extra.cards, #available) do
            local chosen_index = pseudorandom("valk_masc", 1, #available)
            table.insert(chosen, available[chosen_index])
            table.remove(available, chosen_index)
        end

        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                for _, c in pairs(chosen) do
                    c:flip()
                end
                return true
            end,
        })
        delay(2)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                play_sound("tarot1")
                for _, c in pairs(chosen) do
                    SMODS.change_base(c, nil, "Jack")
                    c:juice_up()
                end
                return true
            end,
        })
        delay(2)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                for _, c in pairs(chosen) do
                    c:flip()
                end
                return true
            end,
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = {
        cards = 3,
    } },
    valk_artist = "mailingway",
}

SMODS.Consumable {
    key = "luck",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 4, y = 3 },
    can_use = function(self, card)
        return #G.jokers.cards > 0 and #Valk.util.get_matching(G.jokers.cards, function(e)
            return not e.config.center.immutable
        end) > 1
    end,
    use = function(self, card, area, copier)
        local available = Valk.util.get_matching(G.jokers.cards, function(e)
            return not e.config.center.immutable
        end)
        local chosen = {}
        for i = 1, math.min(card.ability.extra.cards, #available) do
            local chosen_index = pseudorandom("valk_luck", 1, #available)
            table.insert(chosen, available[chosen_index])
            table.remove(available, chosen_index)
        end

        delay(1)
        table.sort(chosen, function(a, b)
            return Valk.util.get_index(a) < Valk.util.get_index(b)
        end)
        for _, c in pairs(chosen) do
            G.E_MANAGER:add_event(Event {
                trigger = "after",
                func = function()
                    local roll = pseudorandom("valk_luck_roll", 1, 2)
                    local v = card.ability.extra.cards
                    play_sound("timpani", roll == 1 and 1.25 or 0.8, 2)
                    Spectrallib.manipulate(c, { value = roll == 1 and v or 1 / v })
                    c:juice_up()
                    return true
                end,
            })
            delay(0.7)
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards, 1 / card.ability.extra.cards } }
    end,
    config = { extra = {
        cards = 2,
    } },
    valk_artist = "mailingway",
}

SMODS.Consumable {
    key = "missingno",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 5, y = 3 },
    can_use = function(self, card)
        return #G.hand.highlighted == 1
    end,
    use = function(self, card, area, copier)
        -- mostly plagarized from vanillaremade
        -- thank you N'
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.4,
            func = function()
                local edition = SMODS.poll_edition { key = "valk_missingno", guaranteed = true, options = { "e_valk_cosmic", "e_valk_glow", "e_valk_rgb" } }
                local aura_card = G.hand.highlighted[1]
                aura_card:set_edition(edition, true)
                card:juice_up(0.3, 0.5)
                return true
            end,
        })
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.e_valk_cosmic
        info_queue[#info_queue + 1] = G.P_CENTERS.e_valk_glow
        info_queue[#info_queue + 1] = G.P_CENTERS.e_valk_rgb
        return { vars = {} }
    end,
    valk_artist = "mailingway",
    update = function(self, card, dt)
        local freq = 66
        local sprite = 5 + (math.sin(G.TIMERS.REAL * freq * math.pi) < 0 and 1 or 0)
        card.children.center:set_sprite_pos { x = sprite, y = 3 }
    end,
    draw = function(self, card, layer)
        if math.sin(G.TIMERS.REAL * 21) < 0 then
            local send = copy_table(card.ARGS.send_to_shader)
            for k, v in ipairs(send) do
                send[k] = (math.sin(G.TIMERS.REAL * 4 + k) + 1) * v * 0.5
            end
            card.children.center:draw_shader("booster", nil, send)
        end
    end,
}

SMODS.Consumable {
    key = "faker",
    set = "Spectral",
    atlas = "misc",
    pos = { x = 8, y = 3 },
    can_use = function(self, card)
        local h = #G.jokers.highlighted
        return h >= 0 and h <= card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        for _, c in pairs(G.jokers.highlighted) do
            local copy = copy_card(c)
            G.jokers:emplace(copy)
            copy:add_to_deck()
            copy:set_edition("e_negative")
            copy:set_perishable(true)
            copy:juice_up()
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = {
        cards = 1,
    } },
    valk_artist = "mailingway",
}

-- todo: deal with this
-- SMODS.Consumable {
--     key = "voidpotential",
--     set = "Spectral",
--     atlas = "misc",
--     pos = {x=1, y=3},
--     config = {extra = {options = 3}},
--     can_use = function(self, card)
--         return true
--     end,
--     use = function(self, card, area, copier)
--         for i=1,card.ability.extra.options do
--             local emplaced = SMODS.add_card({set = "Joker", area = G.play})
--             emplaced.ability.void_potential = true
--             G.GAME.awaiting_void_potential = true
--         end
--         G.E_MANAGER:add_event(Event({
--             trigger = 'after',
--             func = function()
--                 return not G.GAME.awaiting_void_potential
--             end,
--             blockable = true,
--             blocking = false,
--         }))
--     end
-- }

-- Valk.util.hook_after("Card.click", function(orig, self)
--     if Spectrallib.safe_get(self, "ability", "void_potential") then
--         self.area:remove_card(self)
--         G.jokers:emplace(self)
--         self:add_to_deck()
--         self.ability.void_potential = nil
--         G.GAME.awaiting_void_potential = false
--         for _,card in pairs(G.I.CARD) do
--             if Spectrallib.safe_get(card, "ability", "void_potential") then
--                 card:start_dissolve()
--             end
--         end
--     end
-- end)

SMODS.Consumable {
    set = "Spectral",
    key = "freeway",
    atlas = "misc",
    pos = { x = 2, y = 6 },
    soul_pos = { x = 1, y = 6 },
    third_pos = { x = 0, y = 6 },
    can_use = function()
        return Spectrallib.safe_get(G.GAME, "round_resets", "blind_choices", "Boss") ~= "bl_valk_high_road"
    end,
    use = function(self, card, area, copier)
        G.GAME.round_resets.blind_choices.Boss = "bl_valk_high_road"
        if G.blind_select then
            G.blind_select:remove()
            G.blind_prompt_box:remove()
            G.STATE_COMPLETE = false
        end
    end,
    hidden = true,
    soul_rate = 0.03,
    valk_artist = "pangaea",
}
