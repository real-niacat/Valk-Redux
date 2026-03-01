SMODS.ObjectType {
    key = "Kitty",
    default = "j_valk_kitty",
}

function Valk.util.get_kitty_jokers()
    if not G.jokers then
        return 0
    end
    local count = 0
    for _, card in pairs(G.jokers.cards) do
        if Spectrallib.safe_get(card.config.center, "pools", "Kitty") then
            count = count + 1
        end
    end
    return count
end
