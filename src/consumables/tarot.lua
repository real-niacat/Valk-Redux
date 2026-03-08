SMODS.Consumable {
    set = "Tarot",
    key = "judgemeownt",
    can_use = function(self, card)
        return #G.jokers.cards < G.jokers.config.card_limit
    end,
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0.4,
            func = function()
                play_sound("timpani")
                SMODS.add_card { set = "Kitty" }
                card:juice_up(0.3, 0.5)
                return true
            end,
        })
        delay(0.6)
    end,
    valk_artist = "lily",
    atlas = "misc",
    pos = { x = 6, y = 0 },
}
