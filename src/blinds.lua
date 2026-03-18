blindexpander.Passive {
    key = "overscore",
    apply = function(self, blind, pasive, from_disable)
        if not from_disable then
            G.GAME.blind_overscore_thresh = self.config.mult * get_blind_amount(G.GAME.round_resets.ante + 1)
        end
    end,
    calculate = function(self, blind, passive, context)
        if context.after and G.GAME.chips + SMODS.calculate_round_score() > G.GAME.blind_overscore_thresh then
            G.E_MANAGER:add_event(Event {
                trigger = "after",
                func = function()
                    end_round()
                    return true
                end,
            })
        end
    end,
    loc_vars = function(self)
        return { vars = {
            G.GAME.blind_overscore_thresh or (self.config.mult * get_blind_amount(G.GAME.round_resets.ante + 1)),
        } }
    end,
    config = { mult = 3 },
}

blindexpander.Passive {
    key = "swap",
    calculate = function(self, blind, passive, context)
        if context.press_play then
            ease_discard(1)
        end

        if context.pre_discard then
            ease_hands_played(1)
        end
    end,
}

blindexpander.Passive {
    key = "antihighcard",
    calculate = function(self, blind, passive, context)
        if context.before and context.scoring_name == "High Card" then
            Valk.util.mod_blind_size(function(score)
                return score * self.config.mult
            end)
        end
    end,
    loc_vars = function(self)
        return { vars = {
            self.config.mult,
        } }
    end,
    config = { mult = 1.2 },
}

SMODS.Blind {
    key = "high_road",
    boss_colour = HEX("6262FF"),
    boss = {},
    in_pool = function(self)
        return false
    end,
    set_blind = function(self)
        ease_hands_played(-G.GAME.current_round.hands_left + self.config.starting_hands)
        ease_discard(-G.GAME.current_round.discards_left + self.config.starting_discards)
    end,
    config = { starting_hands = 2, starting_discards = 0 },
    mult = 4,
    passives = {
        "psv_valk_overscore",
        "psv_valk_swap",
        "psv_valk_antihighcard",
    },
    loc_vars = function(self)
        return { vars = {
            self.config.starting_hands,
            self.config.starting_discards,
        } }
    end,
    collection_loc_vars = function(self)
        return { vars = {
            self.config.starting_hands,
            self.config.starting_discards,
        } }
    end,
    atlas = "blinds",
    pos = { x = 0, y = 0 },
}

Valk.util.hook("end_round", function(original, ...)
    if Spectrallib.safe_get(G.GAME.blind, "config", "blind", "key") == "bl_valk_high_road" then
        if G.GAME.chips >= G.GAME.blind.chips and G.GAME.chips <= G.GAME.blind_overscore_thresh then
            SMODS.add_card { rarity = "valk_exquisite", set = "Joker", area = G.jokers }
        else
            G.GAME.blind.chips = 0
            G.GAME.chips = G.GAME.blind.chips
            G.STATE = G.STATES.HAND_PLAYED
            G.STATE_COMPLETE = true
        end
    end

    original(...)
end)
