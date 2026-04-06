SMODS.Consumable {
    set = "Tarot",
    key = "judgemeownt",
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card { key = Valk.util.poll_kitty("valk_judgemeownt") }
                card:juice_up(0.3, 0.5)
                return true
            end,
        })
        delay(0.6)
    end,
    valk_artist = "mailingway",
    atlas = "misc",
    pos = { x = 6, y = 0 },
}

Valk.special_tarot_rate = 1
-- defined all at once to save time

SMODS.Consumable {
    set = "Tarot",
    key = "iron_maiden",
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.cards)
        return #selected == card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        local cardlist = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.cards)
        Spectrallib.flip_then(cardlist, function(c)
            copy_card(cardlist[#cardlist], c)
            c:set_ability("c_base")
            if cardlist[1] == c then
                c:set_ability("m_steel")
            end
        end)
    end,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_CENTERS.m_steel
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = { cards = 2 } },
    valk_artist = "scraptake",
    atlas = "misc",
    pos = { x = 0, y = 0 },
    weight = Valk.special_tarot_rate,
}

SMODS.Consumable {
    set = "Tarot",
    key = "the_pope",
    can_use = function(self, card)
        return #G.hand.cards > 0
    end,
    use = function(self, card, area, copier)
        Spectrallib.flip_then(G.hand.cards, function(c)
            if SMODS.pseudorandom_probability(card, "valk_pope", 1, card.ability.extra.den) then
                c:set_ability(SMODS.poll_enhancement { guaranteed = true })
            else
                c:set_ability("c_base")
            end
        end)
    end,
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.den)
        return { vars = { n, d } }
    end,
    config = { extra = { den = 3 } },
    valk_artist = "scraptake",
    atlas = "misc",
    pos = { x = 1, y = 0 },
    weight = Valk.special_tarot_rate,
}

SMODS.Consumable {
    set = "Tarot",
    key = "gods_fingers",
    can_use = function(self, card)
        return #G.hand.cards > card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        local cards = SMODS.shallow_copy(G.hand.cards)
        pseudoshuffle(cards, "valk_gods_fingers")
        for i, pcard in ipairs(cards) do
            if i <= card.ability.extra.cards then
                pcard:start_dissolve()
            end
        end
        SMODS.add_card { rarity = "Common", edition = "e_negative", set = "Joker" }
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = { cards = 3 } },
    valk_artist = "scraptake",
    atlas = "misc",
    pos = { x = 2, y = 0 },
    weight = Valk.special_tarot_rate,
}

SMODS.Consumable {
    set = "Tarot",
    key = "the_killer",
    can_use = function(self, card)
        return G.GAME.last_used_consumable
    end,
    use = function(self, card, area, copier)
        SMODS.add_card { edition = "e_negative", set = G.GAME.last_used_consumable.set }
    end,
    loc_vars = function(self, info_queue, card)
        local set_text = G.GAME.last_used_consumable and G.GAME.last_used_consumable.set or nil
        set_text = set_text and localize("k_" .. set_text:lower()) or localize("k_none")
        local colour = G.C.SECONDARY_SET[G.GAME.last_used_consumable and G.GAME.last_used_consumable.set] or G.C.RED

        local main_end = {
            {
                n = G.UIT.C,
                config = { align = "bm", padding = 0.02 },
                nodes = {
                    {
                        n = G.UIT.C,
                        config = { align = "m", colour = colour, r = 0.05, padding = 0.05 },
                        nodes = {
                            { n = G.UIT.T, config = { text = " " .. set_text .. " ", colour = G.C.UI.TEXT_LIGHT, scale = 0.3, shadow = true } },
                        },
                    },
                },
            },
        }

        return { vars = {}, main_end = main_end }
    end,
    config = { extra = {} },
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 3, y = 0 },
    weight = Valk.special_tarot_rate,
}

SMODS.Consumable {
    set = "Tarot",
    key = "gameshow",
    can_use = function(self, card)
        return G.jokers and #G.jokers.cards > 0
    end,
    use = function(self, card, area, copier)
        for _, joker in pairs(G.jokers.cards) do
            G.E_MANAGER:add_event(Event {
                trigger = "after",
                func = function()
                    joker:juice_up()
                    return true
                end,
            })
            delay(0.6)
            local success = SMODS.pseudorandom_probability(card, "valk_gameshow", 1, card.ability.extra.den)
            if success then
                G.E_MANAGER:add_event(Event {
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        attention_text {
                            text = localize { type = "variable", key = "a_dollars", vars = { card.ability.extra.earn } },
                            scale = 1.3,
                            hold = 1.4,
                            major = joker,
                            backdrop_colour = G.C.MONEY,
                            align = "cm",
                            offset = { x = 0, y = 0.2 },
                            silent = true,
                        }
                        joker:juice_up(0.3, 0.5)
                        return true
                    end,
                })
                ease_dollars(card.ability.extra.earn)
            else
                G.E_MANAGER:add_event(Event {
                    trigger = "after",
                    delay = 0.4,
                    func = function()
                        attention_text {
                            text = localize("k_nope_ex"),
                            scale = 1.3,
                            hold = 1.4,
                            major = joker,
                            backdrop_colour = G.C.SECONDARY_SET.Tarot,
                            align = "cm",
                            offset = { x = 0, y = 0.2 },
                            silent = true,
                        }
                        G.E_MANAGER:add_event(Event {
                            trigger = "after",
                            delay = 0.06 * G.SETTINGS.GAMESPEED,
                            blockable = false,
                            blocking = false,
                            func = function()
                                play_sound("tarot2", 0.76, 0.4)
                                return true
                            end,
                        })
                        play_sound("tarot2", 1, 0.4)
                        joker:juice_up(0.3, 0.5)
                        return true
                    end,
                })
            end
            delay(0.4)
        end
    end,
    loc_vars = function(self, info_queue, card)
        local n, d = SMODS.get_probability_vars(card, 1, card.ability.extra.den)
        return { vars = { n, d, card.ability.extra.earn } }
    end,
    config = { extra = { den = 3, earn = 4 } },
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 4, y = 0 },
    weight = Valk.special_tarot_rate,
}

SMODS.Consumable {
    set = "Tarot",
    key = "the_knight",
    can_use = function(self, card)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.cards)
        return #selected > 0 and #selected <= card.ability.extra.cards
    end,
    use = function(self, card, area, copier)
        local selected = Spectrallib.get_highlighted_cards({ G.hand }, nil, 1, card.ability.extra.cards)
        for _, pcard in pairs(G.hand.cards) do
            if not Spectrallib.in_table(selected, pcard) then
                G.E_MANAGER:add_event(Event {
                    func = function()
                        card:juice_up(0.8, 0.8)
                        pcard:start_dissolve({ G.C.BLACK }, nil, 1.6)
                        play_sound("slice1", 0.96 + math.random() * 0.08)
                        return true
                    end,
                    trigger = "after",
                    delay = 0.4,
                })
                delay(0.4)
            end
        end
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                G.hand:unhighlight_all()
                return true
            end,
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.cards } }
    end,
    config = { extra = { cards = 3 } },
    valk_artist = "pangaea",
    atlas = "misc",
    pos = { x = 5, y = 0 },
    weight = Valk.special_tarot_rate,
}
