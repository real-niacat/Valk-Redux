SMODS.Rarity {
    key = "renowned",
    default_weight = 0.025,
    badge_colour = SMODS.Gradient {
        key = "renowned_gradient",
        colours = {
            HEX("DA61FF"),
            HEX("FF90E3"),
            HEX("6461FF"),
        },
        cycle = 5,
    },
}

SMODS.Joker {
    key = "imwithstupid",
    atlas = "jokers",
    pos = { x = 6, y = 3 },
    config = { extra = { retriggers = 0, retrigger_gain = 1, cards_required = 20, cards_left = 20 } },
    rarity = "valk_renowned",
    cost = 11,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.retriggers,
                card.ability.extra.retrigger_gain,
                card.ability.extra.cards_required,
                card.ability.extra.cards_left,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play then
            card.ability.extra.cards_left = card.ability.extra.cards_left - 1
            if card.ability.extra.cards_left <= 0 then
                SMODS.scale_card(
                    card,
                    { ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrigger_gain" }
                )
                card.ability.extra.cards_left = card.ability.extra.cards_required
            end
        end

        if
            context.retrigger_joker_check
            and Valk.util.get_index(context.other_card) == Valk.util.get_index(card) - 1
            and card.ability.extra.retriggers > 0
        then
            return { repetitions = card.ability.extra.retriggers }
        end
    end,
    pools = { Kitty = true },
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "heavy_hand",
    atlas = "jokers",
    pos = { x = 7, y = 3 },
    config = { extra = { selection_limit = 2, hand_size = 2, chips = 15 } },
    rarity = "valk_renowned",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.selection_limit,
                card.ability.extra.hand_size,
                card.ability.extra.chips,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play then return { chips = card.ability.extra.chips } end
    end,
    add_to_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(card.ability.extra.selection_limit)
        SMODS.change_discard_limit(card.ability.extra.selection_limit)
        G.hand:change_size(card.ability.extra.hand_size)
    end,
    remove_from_deck = function(self, card, from_debuff)
        SMODS.change_play_limit(-card.ability.extra.selection_limit)
        SMODS.change_discard_limit(-card.ability.extra.selection_limit)
        G.hand:change_size(-card.ability.extra.hand_size)
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "ancient_fingers",
    atlas = "jokers",
    pos = { x = 8, y = 3 },
    config = { extra = { handsize = 1, sum = 0 } },
    rarity = "valk_renowned",
    cost = 10,
    loc_vars = function(self, info_queue, card)
        local suit = G.GAME.current_round.ancient_card.suit
        return { vars = { card.ability.extra.handsize, suit, colours = { G.C.SUITS[suit] } } }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.individual
            and context.cardarea == G.play
            and context.other_card:is_suit(G.GAME.current_round.ancient_card.suit)
        then
            G.hand:change_size(card.ability.extra.handsize)
            card.ability.extra.sum = card.ability.extra.sum + card.ability.extra.handsize
        end

        if context.end_of_round and context.main_eval then
            G.hand:change_size(-card.ability.extra.sum)
            card.ability.extra.sum = 0
            SMODS.calculate_effect({ message = localize("k_reset") }, card)
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "leopard_print",
    atlas = "jokers",
    pos = { x = 9, y = 3 },
    config = { extra = {} },
    rarity = "valk_renowned",
    cost = 12,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.retrigger_joker_check and Spectrallib.safe_get(context.other_card.config.center, "pools", "Kitty")
        then
            return { repetitions = Valk.util.get_kitty_jokers() }
        end
    end,
    pools = { Kitty = true },
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "callie",
    atlas = "jokers",
    pos = { x = 0, y = 4 },
    config = { extra = { emult_gain = 0.1, emult = 1, gain_kitty_tag = 0.01, emult_gain_base = 0.1 } },
    rarity = "valk_renowned",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        local bonus = (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        card.ability.extra.emult_gain = card.ability.extra.emult_gain_base + bonus
        return {
            vars = {
                card.ability.extra.emult_gain,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.emult,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.individual
            and context.cardarea == G.play
            and SMODS.has_enhancement(context.other_card, "m_wild")
        then
            local bonus = (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            card.ability.extra.emult_gain = card.ability.extra.emult_gain_base + bonus
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "emult", scalar_value = "emult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.emult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then return { emult = card.ability.extra.emult } end
    end,
    pools = { Kitty = true },
    cost = 10,
    valk_artist = "mailingway",
}

-- TODO: ADD ICE'S CAT HERE

SMODS.Joker {
    key = "rocky",
    atlas = "jokers",
    pos = { x = 2, y = 4 },
    config = { extra = { emult_gain = 0.1, emult = 1, gain_kitty_tag = 0.01, emult_gain_base = 0.1 } },
    rarity = "valk_renowned",
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        local bonus = (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        card.ability.extra.emult_gain = card.ability.extra.emult_gain_base + bonus
        return {
            vars = {
                card.ability.extra.emult_gain,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.emult,
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if
            context.individual
            and context.cardarea == G.play
            and SMODS.has_enhancement(context.other_card, "m_stone")
        then
            local bonus = (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            card.ability.extra.emult_gain = card.ability.extra.emult_gain_base + bonus
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "emult", scalar_value = "emult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.emult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then return { emult = card.ability.extra.emult } end
    end,
    pools = { Kitty = true },
    cost = 10,
    valk_artist = "mailingway",
}
