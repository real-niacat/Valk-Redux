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
            asc = card.ability.extra.asc,
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
