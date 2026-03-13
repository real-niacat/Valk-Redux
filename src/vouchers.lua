SMODS.Voucher {
    key = "reptile",
    calculate = function(self, card, context)
        if context.drawing_cards then
            return {
                cards_to_draw = math.max(context.amount, card.ability.extra.cards),
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = { cards = 2 } },
    cost = 10,
    valk_artist = "mailingway",
    atlas = "misc",
    pos = { x = 0, y = 1 },
}

SMODS.Voucher {
    key = "reptoid",
    calculate = function(self, card, context)
        if context.drawing_cards and G.GAME.current_round.hands_left == G.GAME.round_resets.hands then
            return {
                cards_to_draw = context.amount + card.ability.extra.cards,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = { cards = 2 } },
    cost = 10,
    valk_artist = "mailingway",
    atlas = "misc",
    pos = { x = 1, y = 1 },
}
