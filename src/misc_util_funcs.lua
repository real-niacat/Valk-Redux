function Valk.util.localize_table_of_cards(cards)
    local names = {}
    for _,card in pairs(cards) do
        table.insert(names, localize{type = "name_text", set = card.config.center.set, key = card.config.center_key})
    end
    return names
end

function Valk.util.join_string_table(string_table)
    local str = ""
    for _,entry in pairs(string_table) do
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