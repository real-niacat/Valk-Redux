SMODS.Joker {
    key = "streetlight",
    atlas = "jokers",
    pos = { x = 8, y = 0 },
    config = { extra = { xmult_gain = 0.1, xmult = 1 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and next(SMODS.get_enhancements(context.other_card)) then
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "xmult_gain" })
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    cost = 6,
    valk_artist = "scraptake",
}

SMODS.Joker {
    key = "periapt_beer",
    atlas = "jokers",
    pos = { x = 9, y = 0 },
    config = { extra = {} },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
        info_queue[#info_queue + 1] = G.P_TAGS.tag_charm
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.selling_self then
            if G.consumeables.config.card_limits.total_slots - G.consumeables.config.card_count > 0 then
                SMODS.add_card { key = "c_fool" }
            end
            add_tag(Tag("tag_charm"))
        end
    end,
    cost = 6,
    valk_artist = "pangaea",
}

SMODS.Joker {
    key = "stellar_yogurt",
    atlas = "jokers",
    pos = { x = 0, y = 1 },
    config = { extra = {} },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.c_fool
        info_queue[#info_queue + 1] = G.P_TAGS.tag_meteor
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.selling_self then
            if G.consumeables.config.card_limits.total_slots - G.consumeables.config.card_count > 0 then
                SMODS.add_card { key = "c_fool" }
            end
            add_tag(Tag("tag_meteor"))
        end
    end,
    cost = 6,
    valk_artist = "pangaea",
}

SMODS.Joker {
    key = "hexed_spirit",
    atlas = "jokers",
    pos = { x = 1, y = 1 },
    config = { extra = {} },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_ethereal
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.selling_self then
            for i = 1, 2 do
                add_tag(Tag("tag_ethereal"))
            end
        end
    end,
    cost = 6,
    valk_artist = "pangaea",
}

SMODS.Joker {
    key = "amber",
    atlas = "jokers",
    pos = { x = 2, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.1,
            xmult = 1,
            gain_kitty_tag = 0.01,
            suit = "Diamond",
            suit_plural = "Diamonds",
            xmult_gain_base = 0.1,
        },
    },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.suit,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.xmult,
                colours = {
                    G.C.SUITS[card.ability.extra.suit_plural],
                },
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit_plural) then
            card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "xmult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    pools = { Kitty = true },
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "blackjack",
    atlas = "jokers",
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.1,
            xmult = 1,
            gain_kitty_tag = 0.01,
            suit = "Spade",
            suit_plural = "Spades",
            xmult_gain_base = 0.1,
        },
    },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.suit,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.xmult,
                colours = {
                    G.C.SUITS[card.ability.extra.suit_plural],
                },
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit_plural) then
            card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "xmult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    pools = { Kitty = true },
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "troupe",
    atlas = "jokers",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.1,
            xmult = 1,
            gain_kitty_tag = 0.01,
            suit = "Club",
            suit_plural = "Clubs",
            xmult_gain_base = 0.1,
        },
    },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.suit,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.xmult,
                colours = {
                    G.C.SUITS[card.ability.extra.suit_plural],
                },
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit_plural) then
            card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "xmult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    pools = { Kitty = true },
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "valentine",
    atlas = "jokers",
    pos = { x = 5, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.1,
            xmult = 1,
            gain_kitty_tag = 0.01,
            suit = "Heart",
            suit_plural = "Hearts",
            xmult_gain_base = 0.1,
        },
    },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
        return {
            vars = {
                card.ability.extra.xmult_gain,
                card.ability.extra.suit,
                card.ability.extra.gain_kitty_tag,
                card.ability.extra.xmult,
                colours = {
                    G.C.SUITS[card.ability.extra.suit_plural],
                },
            },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and context.other_card:is_suit(card.ability.extra.suit_plural) then
            card.ability.extra.xmult_gain = card.ability.extra.xmult_gain_base + (card.ability.extra.gain_kitty_tag * Valk.util.get_kitty_tags())
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "xmult_gain" })
        end

        if context.end_of_round and context.main_eval then
            card.ability.extra.xmult = 1
            return {
                message = localize("k_reset"),
            }
        end

        if context.joker_main then
            return { xmult = card.ability.extra.xmult }
        end
    end,
    pools = { Kitty = true },
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "uttered_chaos",
    atlas = "jokers",
    pos = { x = 6, y = 1 },
    config = { extra = { chips_per_char = 2 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.chips_per_char,
                card.ability.extra.chips_per_char * #Valk.util.join_string_table(Valk.util.localize_table_of_cards(card.area.cards)),
            },
        }
    end,
    calculate = function(self, card, context)
        if context.joker_main then
            return {
                chips = card.ability.extra.chips_per_char * #Valk.util.join_string_table(Valk.util.localize_table_of_cards(card.area.cards)),
            }
        end
    end,
    update = function(self, card, dt)
        local rate = 30
        local xpos = 6 + (math.floor(G.TIMERS.REAL * rate) % 2)
        if (G.TIMERS.REAL % 10) < 2 then
            xpos = 6
        end
        local blinking = (G.TIMERS.REAL % 4) < 0.2
        card.children.center:set_sprite_pos {
            x = xpos,
            y = blinking and 1 or 5,
        }
    end,
    pools = { Kitty = true },
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "planedolia",
    atlas = "jokers",
    pos = { x = 8, y = 1 },
    config = { extra = { chance = 2 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return { vars = { n, d } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.modify_shop_card and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.chance) then
            G.E_MANAGER:add_event(Event {
                trigger = "immediate",
                func = function()
                    SMODS.calculate_effect({ message = localize("k_replaced_ex") }, context.card)
                    card:juice_up()
                    context.card:juice_up()
                    context.card:set_ability(Valk.util.poll_set("Planet", self.key))
                    return true
                end,
            })
        end
    end,
    cost = 6,
    valk_artist = "triangle_snack",
}

SMODS.Joker {
    key = "tarodolia",
    atlas = "jokers",
    pos = { x = 9, y = 1 },
    config = { extra = { chance = 4 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return { vars = { n, d } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.modify_shop_card and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.chance) then
            G.E_MANAGER:add_event(Event {
                trigger = "immediate",
                func = function()
                    SMODS.calculate_effect({ message = localize("k_replaced_ex") }, context.card)
                    card:juice_up()
                    context.card:juice_up()
                    context.card:set_ability(Valk.util.poll_set("Tarot", self.key))
                    return true
                end,
            })
        end
    end,
    cost = 6,
    valk_artist = "triangle_snack",
}

SMODS.Joker {
    key = "spectradolia",
    atlas = "jokers",
    pos = { x = 0, y = 2 },
    config = { extra = { chance = 10 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.chance)
        return { vars = { n, d } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.modify_shop_card and SMODS.pseudorandom_probability(card, self.key, 1, card.ability.extra.chance) then
            G.E_MANAGER:add_event(Event {
                trigger = "immediate",
                func = function()
                    SMODS.calculate_effect({ message = localize("k_replaced_ex") }, context.card)
                    card:juice_up()
                    context.card:juice_up()
                    context.card:set_ability(Valk.util.poll_set("Spectral", self.key))
                    return true
                end,
            })
        end
    end,
    cost = 6,
    valk_artist = "triangle_snack",
}

SMODS.Joker {
    key = "merchant_cat",
    atlas = "jokers",
    pos = { x = 1, y = 2 },
    config = { extra = { req = 4 } },
    rarity = 2,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        return { vars = { card.ability.extra.req } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.buying_card and not context.buying_self and context.card.cost > card.ability.extra.req then
            add_tag(Tag("tag_valk_kitty"))
        end
    end,
    pools = { Kitty = true },
    valk_artist = "slipstream",
}

SMODS.Joker {
    key = "roundabout",
    atlas = "jokers",
    pos = { x = 2, y = 2 },
    config = { extra = { ante = -1 } },
    rarity = 2,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.ante } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.modify_ante then
            card:start_dissolve()
            return {
                modify = context.modify_ante + card.ability.extra.ante,
            }
        end
    end,
    valk_artist = "mailingway",
}
