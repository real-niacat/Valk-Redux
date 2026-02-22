Valk.mod.calculate = function(self, context)
    --kitty tag functionality
    if context.final_scoring_step then
        local kitty_tags = Valk.util.get_kitty_tags()
        if kitty_tags < 10 then
            for i,tag in ipairs(G.GAME.tags) do
                G.CARD_H = -G.CARD_H
                SMODS.calculate_effect({chips = kitty_tags * G.GAME.kitty_tag_chips}, tag.HUD_tag )
                G.CARD_H = -G.CARD_H
            end
        else
            local chips = G.GAME.kitty_tag_chips * (kitty_tags^2)
            G.CARD_H = -G.CARD_H
            SMODS.calculate_effect({chips = chips}, G.GAME.tags[1].HUD_tag )
            G.CARD_H = -G.CARD_H
        end
    end
end