---@param context CalcContext
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

    -- XP gained after blind
    if context.end_of_round and context.main_eval then
        G.GAME.valk_leveling.to_add = 0
        G.GAME.valk_leveling.queued_xp = G.GAME.valk_leveling.queued_xp or {}
        G.GAME.valk_leveling.queued_xp["precision"] = Valk.leveling.get_xp_gained(G.GAME.blind.chips, G.GAME.chips)
        G.GAME.valk_leveling.max_reward = G.GAME.valk_leveling.max_reward + G.GAME.valk_leveling.max_reward_scaling
    end

    if context.round_eval then
        Valk.leveling.add_round_eval_row(G.GAME.valk_leveling.queued_xp["precision"], localize("ph_valk_xp_score"))
    end

    if context.starting_shop and G.GAME.valk_leveling.to_add then
        local xp = G.GAME.valk_leveling.to_add
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            func = function()
                Valk.leveling.full_ease_xp(xp)
                G.GAME.valk_leveling.queued_xp = {}
                return true
            end
        }))
    end
end