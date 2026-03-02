SMODS.Joker {
    key = "kathleen",
    atlas = "float",
    pos = { x = 4, y = 1 },
    soul_pos = { x = 5, y = 1 },
    config = { extra = { cards = 5 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    calculate = function(self, card, context)
        if context.setting_blind then
            G.E_MANAGER:add_event(Event {
                trigger = "after",
                func = function()
                    for i = 1, card.ability.extra.cards do
                        local new_card = SMODS.create_card { set = "Playing Card" }
                        new_card:set_ability(Valk.util.poll_set("Planet", self.key))
                        new_card:set_edition(SMODS.poll_edition { guaranteed = true, key = self.key })
                        G.hand:emplace(new_card)
                    end

                    return true
                end,
            })
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "sinep",
    atlas = "float",
    pos = { x = 6, y = 1 },
    soul_pos = { x = 7, y = 1 },
    config = { extra = { gain = 0.069 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play then
            context.other_card.ability.x_chips = context.other_card.ability.x_chips + card.ability.extra.gain
            SMODS.calculate_effect({ message = localize("k_upgrade_ex") }, context.other_card)
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "tasal",
    atlas = "float",
    pos = { x = 8, y = 1 },
    soul_pos = { x = 9, y = 1 },
    config = { extra = { asc = 0, gain = 1, poker_hand = nil } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.gain, card.ability.extra.poker_hand, card.ability.extra.asc } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.joker_main then return {
            plus_asc = card.ability.extra.asc,
        } end

        if context.before and context.scoring_name == card.ability.extra.poker_hand then
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "asc", scalar_value = "gain" })
        end

        if context.after then
            card.ability.extra.poker_hand = Valk.util.poll_hand("tasal", true)
            SMODS.calculate_effect({ message = localize("k_reset") }, card)
        end
    end,
    set_ability = function(self, card, initial, delay_sprites)
        card.ability.extra.poker_hand = Valk.util.poll_hand("tasal", true)
    end,
    valk_artist = "grahkon",
}

function Valk.content.aesthetijoker_owned(area)
    for _, card in pairs(area.cards) do
        if Spectrallib.safe_get(card, "ability", "extra", "aesthetijoker_edition") then return true end
    end
    return false
end

-- AesthetiJoker hook
Valk.util.hook_after("Card.stop_drag", function(original, self)
    if not Valk.content.aesthetijoker_owned(self.area) then return end
    for _, card in pairs(self.area.cards) do
        local left_card = self.area.cards[Valk.util.get_index(card) - 1]
        local right_card = self.area.cards[Valk.util.get_index(card) + 1]
        local le = Spectrallib.safe_get(left_card, "ability", "extra", "aesthetijoker_edition")
        local re = Spectrallib.safe_get(right_card, "ability", "extra", "aesthetijoker_edition")
        if le then
            card:set_edition(le, true, true)
        elseif re then
            card:set_edition(re, true, true)
        else
            card:set_edition(nil, true, true)
        end
    end
end)

SMODS.Joker {
    key = "frutiger",
    atlas = "float",
    pos = { x = 6, y = 2 },
    soul_pos = { x = 7, y = 2 },
    config = { extra = { aesthetijoker_edition = "e_foil", xchips = 1.2 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.xchips,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return {
                xchips = card.ability.extra.xchips,
            }
        end
    end,
}

SMODS.Joker {
    key = "synth",
    atlas = "float",
    pos = { x = 8, y = 2 },
    soul_pos = { x = 9, y = 2 },
    config = { extra = { aesthetijoker_edition = "e_holo", xmult = 1.2 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.xmult,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return { xmult = card.ability.extra.xmult }
        end
    end,
}

SMODS.Joker {
    key = "chrome",
    atlas = "float",
    pos = { x = 4, y = 2 },
    soul_pos = { x = 5, y = 2 },
    config = { extra = { aesthetijoker_edition = "e_polychrome", emult = 1.1 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.emult,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return { emult = 1.1 }
        end
    end,
}

SMODS.Joker {
    key = "vapor",
    atlas = "float",
    pos = { x = 0, y = 3 },
    soul_pos = { x = 1, y = 3 },
    config = { extra = { aesthetijoker_edition = "e_negative", chipsmult = 25 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.chipsmult,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return { chips = card.ability.extra.chipsmult, mult = card.ability.extra.chipsmult }
        end
    end,
}

SMODS.Joker {
    key = "memphis",
    atlas = "float",
    pos = { x = 4, y = 3 },
    soul_pos = { x = 5, y = 3 },
    config = { extra = { aesthetijoker_edition = "e_valk_cosmic", echips = 1.05 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.echips,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return { echips = card.ability.extra.echips }
        end
    end,
}

SMODS.Joker {
    key = "scene",
    atlas = "float",
    pos = { x = 2, y = 3 },
    soul_pos = { x = 3, y = 3 },
    config = { extra = { aesthetijoker_edition = "e_valk_rgb", xchips = 1.25, mult = 25 } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition },
                card.ability.extra.mult,
                card.ability.extra.xchips,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.post_trigger
            and Spectrallib.safe_get(context, "other_card", "edition", "key")
                == card.ability.extra.aesthetijoker_edition
        then
            return {
                mult = card.ability.extra.mult,
                xchips = card.ability.extra.xchips,
            }
        end
    end,
}

SMODS.Joker {
    key = "arkade",
    atlas = "float",
    pos = { x = 2, y = 2 },
    soul_pos = { x = 3, y = 2 },
    config = { extra = { aesthetijoker_edition = "e_valk_glow" } },
    rarity = 4,
    cost = 20,
    loc_vars = function(self, info_queue, card)
        return {
            vars = { localize { type = "name_text", set = "Edition", key = card.ability.extra.aesthetijoker_edition } },
        }
    end,
    -- no calculate necessary
}
