SMODS.Consumable {
    set = "Spectral",
    key = "freeway",
    atlas = "misc",
    pos = { x = 2, y = 6 },
    soul_pos = { x = 1, y = 6 },
    third_pos = { x = 0, y = 6 },
    can_use = function()
        return Spectrallib.safe_get(G.GAME, "round_resets", "blind_choices", "Boss") ~= "bl_valk_high_road"
    end,
    use = function(self, card, area, copier)
        G.GAME.round_resets.blind_choices.Boss = "bl_valk_high_road"
        if G.blind_select then
            G.blind_select:remove()
            G.blind_prompt_box:remove()
            G.STATE_COMPLETE = false
        end
    end,
    hidden = true,
    soul_rate = 0.03,
    valk_artist = "pangaea",
}
