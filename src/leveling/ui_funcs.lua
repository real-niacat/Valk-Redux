Valk.leveling.easing_return = "outcirc"
Valk.leveling.easing_drop = "outcirc"
Valk.leveling.anim_runtime = 1
function Valk.leveling.drop_ui(skip_jokers)
    local time = Valk.leveling.anim_runtime
    local easing = Valk.leveling.easing_drop
    local multiplier = 1.5
    G.GAME.valk_leveling.ui_state = { type = "drop", complete = false }
    if not skip_jokers then
        G.E_MANAGER:add_event(
            Event {
                trigger = "ease",
                ease = easing, --easing type
                ref_table = G.jokers.T,
                ref_value = "y",
                ease_to = -1.25, --end value
                delay = time * multiplier, --time taken
                func = function(t)
                    return t
                end,
            },
            "valk_2"
        )
    end

    G.E_MANAGER:add_event(
        Event {
            trigger = "ease",
            ease = easing, --easing type
            ref_table = G.valk_level_progress.config.offset,
            ref_value = "y",
            ease_to = 2.1, --end value
            delay = time * multiplier, --time taken
            func = function(t)
                return t
            end,
        },
        "valk_1"
    )

    G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = time * multiplier,
        func = function()
            G.GAME.valk_leveling.ui_state = { type = "drop", complete = true }
            return true
        end,
        blocking = false,
        blockable = true,
    })
end

function Valk.leveling.return_ui(skip_jokers)
    local time = Valk.leveling.anim_runtime
    local easing = Valk.leveling.easing_return
    G.GAME.valk_leveling.ui_state = { type = "return", complete = false }
    if not skip_jokers then
        G.E_MANAGER:add_event(
            Event {
                trigger = "ease",
                ease = easing, --easing type
                ref_table = G.jokers.T,
                ref_value = "y",
                ease_to = 0, --end value
                delay = time, --time taken
                func = function(t)
                    return t
                end,
            },
            "valk_2"
        )
    end

    G.E_MANAGER:add_event(
        Event {
            trigger = "ease",
            ease = easing, --easing type
            ref_table = G.valk_level_progress.config.offset,
            ref_value = "y",
            ease_to = -3, --end value
            delay = time, --time taken
            func = function(t)
                return t
            end,
        },
        "valk_1"
    )

    G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = time,
        func = function()
            G.GAME.valk_leveling.ui_state = { type = "return", complete = true }
            return true
        end,
        blocking = false,
        blockable = true,
    })
end

Valk.leveling.xp_easing = "inexpo"
function Valk.leveling.ease_xp(amount, leveling_callback)
    -- ease to max(current_xp+amount, requirement)
    -- if current_xp+amount > requirement, level up
    local leveling = G.GAME.valk_leveling
    leveling.in_animation = true

    local xps = {}
    local level = leveling.level
    local req = leveling.req
    local to_val = leveling.xp + amount
    while to_val >= 0 do
        table.insert(xps, math.min(to_val, req))
        to_val = to_val - req
        level = level + 1
        req = Valk.leveling.get_requirement(level)
    end
    local base_time = 2.8
    local total_time_taken = 0
    local timertype = nil

    for i, ease_to in ipairs(xps) do
        local time = base_time / (2 ^ (i - 1))
        local final = (i == #xps)
        if final then time = base_time * 1.5 end
        total_time_taken = total_time_taken + time
        G.E_MANAGER:add_event(Event {
            trigger = "after",
            delay = 0,
            timer = timertype,
            func = function()
                G.E_MANAGER:add_event(
                    Event {
                        trigger = "ease",
                        ease = Valk.leveling.xp_easing, --easing type
                        ref_table = leveling,
                        ref_value = "xp",
                        ease_to = ease_to, --end value
                        delay = time, --time taken
                        timer = timertype,
                        func = function(t)
                            return t
                        end,
                    },
                    "valk_1"
                )
                G.E_MANAGER:add_event(
                    Event {
                        trigger = "after",
                        delay = time,
                        timer = timertype,
                        func = function()
                            if leveling.xp >= leveling.req then
                                leveling.level = leveling.level + 1
                                leveling.xp = 0
                                leveling.req = Valk.leveling.get_requirement(leveling.level)
                                Valk.leveling.level_up(leveling.level)
                                if leveling_callback then leveling_callback(leveling.level) end
                            end
                            if amount == 0 then
                                -- nope!
                                attention_text {
                                    text = localize("k_nope_ex"),
                                    scale = 1,
                                    hold = 1,
                                    backdrop_colour = G.C.FILTER,
                                    align = "cm",
                                    major = G.valk_level_progress,
                                    offset = { x = 0, y = 2 },
                                }
                            end
                            if final then leveling.in_animation = false end
                            return true
                        end,
                    },
                    "valk_1"
                )
                return true
            end,
        })
    end
end

function Valk.leveling.full_ease_xp(amount, skip, callback)
    G.E_MANAGER:add_event(
        Event {
            trigger = "after",
            delay = 2,
            func = function()
                Valk.leveling.drop_ui(skip)
                G.E_MANAGER:add_event(
                    Event {
                        trigger = "after",
                        delay = 2,
                        func = function()
                            -- ACTUALLY DOES XP STUFF HERE
                            Valk.leveling.ease_xp(amount, callback)
                            G.E_MANAGER:add_event(
                                Event {
                                    trigger = "after",
                                    delay = 2,
                                    blocking = false,
                                    func = function()
                                        if not G.GAME.valk_leveling.in_animation then
                                            G.E_MANAGER:add_event(
                                                Event {
                                                    trigger = "after",
                                                    delay = 2,
                                                    func = function()
                                                        Valk.leveling.return_ui(skip)
                                                        return true
                                                    end,
                                                },
                                                "valk_1"
                                            )
                                            return true
                                        end
                                    end,
                                },
                                "valk_1"
                            )
                            return true
                        end,
                    },
                    "valk_1"
                )

                return true
            end,
        },
        "valk_1"
    )
end

function Valk.leveling.add_round_eval_row(xp, source)
    G.GAME.valk_leveling.to_add = G.GAME.valk_leveling.to_add or 0
    G.GAME.valk_leveling.to_add = G.GAME.valk_leveling.to_add + xp
    add_round_eval_row {
        name = "custom",
        number = xp,
        text = localize("ph_valk_xp") .. " " .. source,
        pitch = 0.95 + ((total_cashout_rows or 3) * 0.06),
        dollars = 0,
        number_colour = G.C.valk_prim,
        bonus = true,
    }
end

Valk.util.hook_after("Game.update", function()
    local next_round = G.shop and G.shop:get_UIE_by_ID("next_round_button")
    if next_round then
        local state = G.GAME.valk_leveling.ui_state
        if state.complete and state.type == "return" then
            next_round.config.button = "toggle_shop"
            next_round.config.colour = G.C.RED
        else
            next_round.config.button = nil
            next_round.config.colour = G.C.UI.BACKGROUND_INACTIVE
        end
    end
    -- print(s)
end)
