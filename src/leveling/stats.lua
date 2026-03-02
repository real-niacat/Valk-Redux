Valk.util.hook("Game.init_game_object", function(original, ...)
    local game = original(...)
    game.valk_leveling = {
        xp = 0,
        req = Valk.leveling.get_requirement(1),
        level = 1,
        reward = 1,
        max_reward = 125, -- base reward
        max_reward_scaling = 25, -- at end of round increases by this much
        ui_state = { complete = true },
        gate_intensity = 0,
        leniency = 2, -- higher number = easier to gain 100% xp per blind
    }
    return game
end)

Valk.util.hook_after("Game.update", function()
    if not G.GAME.valk_leveling then
        return
    end

    for key, value in pairs(G.GAME.valk_leveling) do
        if type(value) == "number" then
            G.GAME.valk_leveling[key .. "_display"] = string.format("%.0f", value)
        end
    end
end)

function Valk.leveling.get_requirement(level)
    return 100 + ((level - 1) * 50)
end

function Valk.leveling.get_gate(ante)
    local div = 8
    local pow = 1.5
    return math.floor(div * ((math.floor(ante) / div) ^ pow))
    -- return math.floor(ante*0.7)
end

function Valk.leveling.calc_gate(mod)
    local new_ante = G.GAME.round_resets.ante + mod
    local gate = Valk.leveling.get_gate(new_ante)
    local diff = (gate - G.GAME.valk_leveling.level)
    G.GAME.valk_leveling.gate_intensity = math.max(G.GAME.valk_leveling.gate_intensity + diff, 0)
end

function Valk.leveling.get_xp_gained(blind_size, score)
    local d = G.GAME.valk_leveling.leniency
    local numerator = blind_size ^ (1 / d)
    local denominator = score ^ (1 / d)
    local percent = numerator / denominator
    return Valk.util.ui_safe(math.floor(percent * G.GAME.valk_leveling.max_reward))
end

function Valk.leveling.level_up(new_level)
    ease_dollars(G.GAME.valk_leveling.reward) -- you earn 1 dollar when leveling up. thats it
    G.valk_level_progress:get_UIE_by_ID("level_display"):juice_up()
end

function Valk.leveling.get_next_gate()
    local cur_ante = G.GAME.round_resets.ante
    if cur_ante >= G.GAME.win_ante then
        return cur_ante + 1
    end
    return G.GAME.win_ante + 1
end
