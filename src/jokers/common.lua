SMODS.Joker {
    key = "suck_it",
    atlas = "jokers",
    pos = { x = 2, y = 0 },
    config = { extra = { lossden = 11, loss = 5, gainden = 15, gain = 20 } },
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        local ln, ld = SMODS.get_probability_vars(card, 1, card.ability.extra.lossden)
        local gn, gd = SMODS.get_probability_vars(card, 1, card.ability.extra.gainden)
        return {
            vars = {
                ln,
                ld,
                card.ability.extra.loss,
                gn,
                gd,
                card.ability.extra.gain,
            },
        }
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            local loss = SMODS.pseudorandom_probability(card, "suck_it_loss", 1, card.ability.extra.lossden)
            local gain = SMODS.pseudorandom_probability(card, "suck_it_gain", 1, card.ability.extra.gainden)
            if gain then
                ease_dollars(card.ability.extra.gain)
                return
            elseif loss then
                ease_dollars(-card.ability.extra.loss)
            end
            local new_copy = SMODS.add_card { key = self.key }
            new_copy.sell_cost = 0
        end
    end,
    cost = 1,
    valk_artist = "pangaea",
}

SMODS.Joker {
    key = "antithesis",
    atlas = "jokers",
    pos = { x = 3, y = 0 },
    config = { extra = { mult = 5 } },
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        if context.individual and context.cardarea == "unscored" then
            return { mult = card.ability.extra.mult }
        end
    end,
    cost = 3,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "kitty",
    atlas = "jokers",
    pos = { x = 4, y = 0 },
    config = { extra = {} },
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.end_of_round and context.main_eval then
            add_tag(Tag("tag_valk_kitty"))
            SMODS.calculate_effect({ message = localize("k_plus_kitty_tag") }, card)
        end
    end,
    pools = { Kitty = true },
    cost = 3,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "posh",
    atlas = "jokers",
    pos = { x = 5, y = 0 },
    config = { extra = { chips = 30 } },
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.hand and next(SMODS.get_enhancements(context.other_card)) then
            return { chips = card.ability.extra.chips }
        end
    end,
    cost = 4,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "fancy",
    atlas = "jokers",
    pos = { x = 6, y = 0 },
    config = { extra = { mult = 5 } },
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.hand and not context.end_of_round and next(SMODS.get_enhancements(context.other_card)) then
            return { mult = card.ability.extra.mult }
        end
    end,
    cost = 4,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "takeyourage",
    atlas = "jokers",
    pos = { x = 3, y = 2 },
    config = { extra = { mult = 25 } },
    rarity = 1,
    cost = 3,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.mult, -card.ability.extra.mult } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.initial_scoring_step then
            return { mult = card.ability.extra.mult }
        end
        if context.final_scoring_step then
            return { mult = -card.ability.extra.mult }
        end
    end,
    valk_artist = "mailingway",
}
