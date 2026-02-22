SMODS.ObjectType {
    key = "Kitty",
    default = "j_valk_kitty", 
}

function Valk.util.get_kitty_jokers()
    local count = 0
    for _,area in pairs(SMODS.get_card_areas("joker")) do
        for _,card in pairs(area.cards) do
            
            if card.config.center.pools and card.config.center.pools.Kitty then
                count = count + 1
            end

        end
    end
    return count
end