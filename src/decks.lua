SMODS.Back {
    key = "inertia",
    atlas = "misc",
    pos = { x = 0, y = 5 },
    apply = function(self, back)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                G.GAME.valk_leveling.leniency = G.GAME.valk_leveling.leniency - self.config.xp
                G.GAME.blindsize_exponent = self.config.esize
                return true
            end,
        })
    end,
    config = { xp = 0.5, esize = 0.9 },
    loc_vars = function(self, info_queue, card)
        return { vars = {
            self.config.esize,
            self.config.xp,
        } }
    end,
    valk_artist = "scraptake",
}

Valk.util.hook("get_blind_amount", function(original, ante)
    return original(ante) ^ (G.GAME.blindsize_exponent or 1)
end)

SMODS.Back {
    key = "encore",
    atlas = "misc",
    pos = { x = 1, y = 5 },
    calculate = function(self, back, context)
        if context.retrigger_joker_check then
            return { repetitions = 1 }
        end
    end,
    apply = function(self, back)
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            func = function()
                G.jokers:change_size(self.config.minus_slots)
                return true
            end,
        })
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { self.config.minus_slots } }
    end,
    config = { minus_slots = -2 },
    valk_artist = "scraptake",
}
