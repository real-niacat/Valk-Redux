-- SMODS.ObjectType {
--     key = "Kitty",
--     default = "j_valk_kitty",
--     rarities = {
--         { key = "Common" },
--         { key = "Uncommon" },
--         { key = "Rare" },
--         { key = "valk_renowned" },
--     },
-- }

SMODS.Attribute {
    key = "kitty",
}

-- mf was here
function Valk.util.has_attribute(card, key)
	local card_key = card
	if Object.is(card, Card) then card_key = card.config.center.key end
	local pool = SMODS.get_attribute_pool(key)
	for _, c in pairs(pool) do
		if c == card_key then return true end
	end
	return false
end

---@return number
function Valk.util.get_kitty_jokers()
    if not G.jokers then
        return 0
    end
    local count = 0
    for _, card in pairs(G.jokers.cards) do
        if Valk.util.has_attribute(card, "kitty") then
            count = count + 1
        end
    end
    return count
end
