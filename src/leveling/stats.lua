Valk.util.hook("Game.init_game_object", function(original, ...)
    local game = original(...)
    game.valk_leveling = {
        xp = 0,
        req = 100,
        level = 1,
        reward = 1,
        max_reward = 100,
        max_reward_scaling = 10, -- at end of round increases by this much
    }
    return game
end)

Valk.util.hook_after("Game.update", function()
    if not G.GAME.valk_leveling then
        return
    end

    for key,value in pairs(G.GAME.valk_leveling) do
        if type(value) == "number" then
            G.GAME.valk_leveling[key .. "_display"] = string.format("%.0f", value)
        end
    end
end)

function Valk.leveling.get_requirement(level)
    return level * 100
end

function Valk.leveling.calc_gate(ante)
    return math.floor(ante*0.7)
end

function Valk.leveling.get_xp_gained(blind_size, score)
    local d = to_big(1.5)
    local numerator = blind_size ^ d
    local denominator = score ^ d
    local percent = numerator / denominator
    return Valk.util.ui_safe(math.floor(percent*G.GAME.valk_leveling.max_reward))
end

function Valk.leveling.level_up(new_level)
    ease_dollars(G.GAME.valk_leveling.reward) -- you earn 1 dollar when leveling up. thats it
end