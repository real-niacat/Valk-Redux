function Valk.util.localize_table_of_cards(cards)
    local names = {}
    for _, card in pairs(cards) do
        table.insert(names, localize { type = "name_text", set = card.config.center.set, key = card.config.center_key })
    end
    return names
end

function Valk.util.join_string_table(string_table)
    local str = ""
    for _, entry in pairs(string_table) do
        str = str .. entry
    end
    return str
end

function Valk.util.poll_set(set, seed)
    local pool = get_current_pool(set)
    local i = 1
    local element = pseudorandom_element(pool, seed .. i)
    while element == "UNAVAILABLE" do
        i = i + 1
        element = pseudorandom_element(pool, seed .. i)
    end
    return element
end

function Valk.util.poll_sets(sets, seed)
    local pool = {}
    for _, set in ipairs(sets) do
        pool = Valk.util.merge_arrays(pool, copy_table(get_current_pool(set)))
    end
    local i = 1
    local element = pseudorandom_element(pool, seed .. i)
    while element == "UNAVAILABLE" do
        i = i + 1
        element = pseudorandom_element(pool, seed .. i)
    end
    return element
end

function Valk.util.get_index(card)
    for i, i_card in ipairs(card.area.cards) do
        if i_card == card then
            return i
        end
    end
    error("Card not found in its own area. What the fuck are you doing?")
end

-- Merges two tables, giving the key-value pairs of both. Table B has higher priority if there are identical/overlapping keys
function Valk.util.merge_tables(a, b)
    local new = {}
    for key, value in pairs(a) do
        new[key] = value
    end
    for key, value in pairs(b) do
        new[key] = value
    end
    return new
end

function Valk.util.merge_arrays(a, b)
    local new = {}
    for i, value in ipairs(a) do
        table.insert(new, value)
    end
    for i, value in ipairs(b) do
        table.insert(new, value)
    end
    return new
end

function Valk.util.ui_safe(number)
    number = to_number(number)
    number = math.min(number, 1e100)
    number = math.max(number, -1e100)

    return number
end

function Valk.util.reload_localization()
    for i, v in pairs(SMODS.Mods) do
        if v.can_load and v.path then
            SMODS.handle_loc_file(v.path)
        end
    end
    return init_localization()
end

SMODS.Keybind {
    key = "reload_loc",
    key_pressed = "d",
    action = function(self)
        Valk.util.reload_localization()
    end,
}

function Valk.util.poll_hand(seed, visible_only, exclude)
    local poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if (visible_only and SMODS.is_poker_hand_visible(handname) or not visible_only) and handname ~= exclude then
            table.insert(poker_hands, handname)
        end
    end
    return pseudorandom_element(poker_hands, seed)
end
