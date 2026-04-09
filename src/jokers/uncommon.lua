SMODS.Joker {
    key = "streetlight",
    atlas = "jokers",
    pos = { x = 8, y = 0 },
    config = { extra = { xmult_gain = 0.05, xmult = 1 } },
    rarity = 2,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult_gain, card.ability.extra.xmult } }
    end,
    attributes = { "xmult", "scaling", "enhancements" },
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
    attributes = { "on_sell", "generation", "tarot", "tag", "food" },
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
    attributes = { "on_sell", "generation", "tarot", "tag", "food" },
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
    attributes = { "on_sell", "generation", "tag", "food" },
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
            xmult_gain = 0.05,
            xmult = 1,
            gain_kitty_tag = 0.02,
            suit = "Diamond",
            suit_plural = "Diamonds",
            xmult_gain_base = 0.05,
        },
    },
    rarity = 2,
    attributes = { "xmult", "scaling", "suit", "diamonds", "tag", "reset", "kitty" },
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
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "blackjack",
    atlas = "jokers",
    pos = { x = 3, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.05,
            xmult = 1,
            gain_kitty_tag = 0.02,
            suit = "Spade",
            suit_plural = "Spades",
            xmult_gain_base = 0.05,
        },
    },
    rarity = 2,
    attributes = { "xmult", "scaling", "suit", "spades", "tag", "reset", "kitty" },
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
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "troupe",
    atlas = "jokers",
    pos = { x = 4, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.05,
            xmult = 1,
            gain_kitty_tag = 0.02,
            suit = "Club",
            suit_plural = "Clubs",
            xmult_gain_base = 0.05,
        },
    },
    rarity = 2,
    attributes = { "xmult", "scaling", "suit", "clubs", "tag", "reset", "kitty" },
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
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "valentine",
    atlas = "jokers",
    pos = { x = 5, y = 1 },
    config = {
        extra = {
            xmult_gain = 0.05,
            xmult = 1,
            gain_kitty_tag = 0.02,
            suit = "Heart",
            suit_plural = "Hearts",
            xmult_gain_base = 0.05,
        },
    },
    rarity = 2,
    attributes = { "xmult", "scaling", "suit", "hearts", "tag", "reset", "kitty" },
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
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "uttered_chaos",
    atlas = "jokers",
    pos = { x = 6, y = 1 },
    config = { extra = { chips_per_char = 2 } },
    rarity = 2,
    attributes = { "chips", "jokers", "kitty" },
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
    cost = 5,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "planedolia",
    atlas = "jokers",
    pos = { x = 8, y = 1 },
    config = { extra = { chance = 2 } },
    rarity = 2,
    attributes = { "chance", "planet" },
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
                    create_shop_card_ui(context.card)
                    context.card:set_cost()
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
    attributes = { "chance", "tarot" },
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
                    create_shop_card_ui(context.card)
                    context.card:set_cost()
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
    attributes = { "chance", "spectral" },
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
                    create_shop_card_ui(context.card)
                    context.card:set_cost()
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
    attributes = { "generation", "tag", "kitty" },
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
    valk_artist = "slipstream",
}

SMODS.Joker {
    key = "roundabout",
    atlas = "jokers",
    pos = { x = 2, y = 2 },
    config = { extra = { ante = -1 } },
    rarity = 2,
    cost = 6,
    attributes = {},
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

SMODS.Joker {
    key = "kopa",
    atlas = "jokers",
    pos = { x = 1, y = 4 },
    config = { extra = {} },
    rarity = 2,
    cost = 7,
    attributes = { "hands", "editions", "kitty" },
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.first_hand_drawn and not context.blueprint then
            local eval = function()
                return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES
            end
            juice_card_until(card, eval, true)
        end
        if context.before and G.GAME.current_round.hands_played == 0 and #context.full_hand == 1 then
            context.full_hand[1]:set_edition("e_polychrome")
        end
    end,
    valk_artist = "mailingway",
}

function Valk.util.to_brainfuck(t)
    local fixed = {}
    for i, card in ipairs(t) do
        table.insert(fixed, { suit = card.base.suit, face = not not card:is_face() })
    end
    local ref = {
        ["Spades"] = { [true] = "+", [false] = "-" },
        ["Hearts"] = { [true] = ">", [false] = "<" },
        ["Clubs"] = { [true] = "[", [false] = "]" },
        ["Diamonds"] = { [true] = ",", [false] = "." },
    }
    local b = ""
    for i, en in ipairs(fixed) do
        b = b .. (ref[en.suit] and ref[en.suit][en.face] or "")
    end
    return b
end

function Valk.content.interpret_bf(code)
    local function incl_mod(x, l, u)
        return (x - l) % (u - l + 1) + l
    end

    local function find_next(value, starting_index, tab)
        for i = starting_index, #tab do
            if tab[i] == value then
                return i
            end
        end
    end

    local chars = {}
    for i = 1, #code do
        chars[i] = code:sub(i, i)
    end

    local tape = {}
    for i = 1, 8 do
        table.insert(tape, 0)
    end
    local loop_index_stack = {}
    local output = {}
    local index = 1
    local ptr = 1
    local done = false
    local funcs = {
        ["+"] = function()
            tape[ptr] = (tape[ptr] + 1) % 256
        end,
        ["-"] = function()
            tape[ptr] = (tape[ptr] - 1) % 256
        end,
        [">"] = function()
            ptr = incl_mod(ptr + 1, 1, #tape)
        end,
        ["<"] = function()
            ptr = incl_mod(ptr - 1, 1, #tape)
        end,
        ["["] = function()
            if tape[ptr] ~= 0 then
                table.insert(loop_index_stack, index)
            else
                index = find_next("]", index, chars)
            end
        end,
        ["]"] = function()
            if tape[ptr] ~= 0 then
                index = loop_index_stack[#loop_index_stack]
            else
                index = find_next("]", index, chars)
            end
        end,
        ["."] = function()
            table.insert(output, tape[ptr])
        end,
        [","] = function() end,
    }
    while not done do
        local func = funcs[chars[index]]
        if func then
            func()
        end
        index = index + 1
        if chars[index] == nil then
            done = true
        end
    end
    return output
end

function Valk.content.get_bf_desc(effects)
    local b = {}
    for _, effect in pairs(effects) do
        if effect.value ~= 0 then
            local unparsed = G.localization.misc.v_dictionary["k_valk_bf_" .. effect.type]
            unparsed = unparsed:gsub("#1#", format_ui_value(effect.value))
            table.insert(b, unparsed)
        end
    end
    return b
end

function Valk.content.get_bf_effects(outputs)
    local ref = {
        {
            type = "chips",
            conv = function(x)
                return x
            end,
        },
        {
            type = "mult",
            conv = function(x)
                return x / 5
            end,
        },
        {
            type = "money",
            conv = function(x)
                return math.log10(x)
            end,
        },
        {
            type = "blindsize",
            conv = function(x)
                return math.log(x, 100)
            end,
            no_floor = true,
        },
        {
            type = "forcetrigger",
            conv = function(x)
                return 3 * math.sin((math.pi * x) / (2 * 127))
            end,
        },
        {
            type = "ante",
            conv = function(x)
                return math.log10(x)
            end,
        },
        {
            type = "consumables",
            conv = function(x)
                return 3 * math.sin((math.pi * x) / (2 * 65))
            end,
        },
        {
            type = "negative_blindsize",
            conv = function(x)
                return x ^ 0.9
            end,
        },
    }
    local effects = {}
    for i, value in ipairs(outputs) do
        local v = ref[i]
        if v and v.conv(value) > 0 then
            table.insert(effects, { type = v.type, value = v.no_floor and v.conv(value) or math.floor(v.conv(value)) })
        end
    end
    return effects
end

-- SMODS.Joker {
local brainfuck = {
    key = "brainfuck",
    -- atlas = "",
    -- pos = {x=,y=},
    config = { extra = { code = "", effects = {} } },
    rarity = 2,
    cost = 10,
    attributes = { "mult", "chips", "economy", "suit", "hearts", "diamonds", "clubs", "spades", "rank", "xblindsize" },
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.area.config.collection and "+++" or card.ability.extra.code,
                G.hand and Valk.util.to_brainfuck(G.hand.highlighted) or "[->++<].",
            },
            main_end = { Valk.util.get_description_ui(Valk.content.get_bf_desc(card.ability.extra.effects)) },
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.before and G.GAME.current_round.hands_played == 0 then
            card.ability.extra.code = card.ability.extra.code .. Valk.util.to_brainfuck(context.full_hand)
        end

        if context.joker_main then
            local ret = {}
            for _, effect in pairs(card.ability.extra.effects) do
                if effect.type == "mult" then
                    ret.mult = effect.value
                end
                if effect.type == "chips" then
                    ret.chips = effect.value
                end
                if effect.type == "money" then
                    ret.dollars = effect.value
                end
                if effect.type == "forcetrigger" then
                    for i = 1, effect.value do
                        Spectrallib.forcetrigger {
                            card = pseudorandom_element(G.jokers.cards, "valk_bf_forcetrigger"),
                            context = context,
                            colour = G.C.FILTER,
                            message_card = card,
                        }
                    end
                end
                if effect.type == "negative_blindsize" then
                    Valk.util.mod_blind_size(function(a)
                        return a - effect.value
                    end)
                end
            end
            return ret
        end
    end,
    use = function(self, card)
        local output = Valk.content.interpret_bf(card.ability.extra.code)
        card.ability.extra.code = ""
        card.ability.extra.effects = Valk.content.get_bf_effects(output)

        for _, effect in pairs(card.ability.extra.effects) do
            if effect.type == "ante" then
                ease_ante(effect.value)
            end
            if effect.type == "blindsize" then
                G.GAME.blind_size_multiplier = G.GAME.blind_size_multiplier * effect.value
            end
            if effect.type == "consumables" then
                for i = 1, effect.value do
                    SMODS.add_card { set = "Consumeables", area = G.consumeables }
                end
            end
        end
    end,
    can_use = function(self, card)
        return #card.ability.extra.code > 0
    end,
}
