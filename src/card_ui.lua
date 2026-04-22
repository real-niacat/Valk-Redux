local function replace_numbers(str)
    local built_str = ""
    for i = 1, #str do
        local char = str:sub(i, i)
        if tonumber(char) then
            built_str = built_str .. "?"
            -- print("adding question mark")
        else
            built_str = built_str .. char
            -- print("adding base")
        end
    end
    return built_str
end

function Valk.util.modify_card_ui(full_ui, card)
    local res = Spectrallib.safe_get(card, "edition", "key")
    if res ~= "e_valk_censored" then
        return
    end

    Valk.util.traverse_table(full_ui, function(v)
        return type(v) == "string"
    end, replace_numbers)
end
