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

SMODS.Voucher {
    key = "xp_alpha",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xp } }
    end,
    redeem = function(self, voucher)
        G.GAME.valk_leveling.xp_multiplier = G.GAME.valk_leveling.xp_multiplier * voucher.ability.extra.xp
    end,
    config = { extra = { xp = 1.5 } },
    cost = 10,
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 5, y = 1 },
}

SMODS.Voucher {
    key = "xp_beta",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money, card.ability.extra.len } }
    end,
    calculate = function(self, card, context)
        if context.valk_level_up then
            ease_dollars(card.ability.extra.money)
        end
    end,
    redeem = function(self, voucher)
        G.GAME.valk_leveling.leniency = G.GAME.valk_leveling.leniency + voucher.ability.extra.len
    end,
    config = { extra = { money = 2, len = 1 } },
    cost = 10,
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 6, y = 1 },
    requires = { "v_valk_xp_alpha" },
}

SMODS.Voucher {
    key = "xp_gamma",
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        if context.valk_level_up then
            local hand, played = "High Card", 0
            for key, h in pairs(G.GAME.hands) do
                if h.played > played then
                    played = h.played
                    hand = key
                end
            end
            SMODS.upgrade_poker_hands { hands = { hand }, level_up = 1 }
        end
    end,
    config = { extra = {} },
    cost = 10,
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 7, y = 1 },
    requires = { "v_valk_xp_beta" },
}

SMODS.Voucher {
    key = "xp_delta",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xp } }
    end,
    redeem = function(self, voucher)
        G.GAME.valk_leveling.xp_multiplier = G.GAME.valk_leveling.xp_multiplier * voucher.ability.extra.xp
    end,
    config = { extra = { xp = 5 } },
    cost = 10,
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 8, y = 1 },
    requires = { "v_valk_xp_gamma" },
}

SMODS.Voucher {
    key = "xp_epsilon",
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xp } }
    end,
    calculate = function(self, card, context)
        if context.valk_level_up then
            SMODS.add_card { set = "Spectral", area = G.consumeables }
        end
    end,
    config = { extra = {} },
    cost = 10,
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 9, y = 1 },
    requires = { "v_valk_xp_delta" },
}
