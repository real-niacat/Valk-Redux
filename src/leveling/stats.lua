Valk.util.hook("Game.init_game_object", function(original, ...)
    local game = original(...)
    game.valk_leveling = {
        xp = 0,
        req = 100,
        level = 1
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

Valk.leveling.xp_easing = "inexpo"
function Valk.leveling.ease_xp(amount)
    -- ease to max(current_xp+amount, requirement)
    -- if current_xp+amount > requirement, level up

    local leveling = G.GAME.valk_leveling
    leveling.in_animation = true

    local xps = {}
    local level = leveling.level
    local req = leveling.req
    local to_val = leveling.xp + amount
    while to_val > 0 do
        table.insert(xps, math.min(to_val, req))
        to_val = to_val - req
        level = level + 1
        req = Valk.leveling.get_requirement(level)
    end
    local base_time = 0.7
    local total_time_taken = 0
    local timertype = "REAL"

    for i, ease_to in ipairs(xps) do
        local time = base_time / (2 ^ (i - 1))
        local final = (i == #xps)
        if final then time = base_time*1.5 end 
        total_time_taken = total_time_taken + time
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0,
            timer = timertype,
            func = function()
                G.E_MANAGER:add_event(Event({
                    trigger = 'ease',
                    ease = Valk.leveling.xp_easing, --easing type
                    ref_table = leveling,
                    ref_value = "xp",
                    ease_to = ease_to, --end value
                    delay = time, --time taken
                    timer = timertype,
                    func = (function(t) return t end),
                }))
                G.E_MANAGER:add_event(Event({
                    trigger = 'after',
                    delay = time,
                    timer = timertype,
                    func = function()
                        if leveling.xp >= leveling.req then
                            leveling.level = leveling.level + 1
                            leveling.xp = 0 
                            leveling.req = Valk.leveling.get_requirement(leveling.level)
                        end
                        if final then 
                            leveling.in_animation = false
                        end
                        return true
                    end
                }))
                return true
            end
        }))
    end
end
