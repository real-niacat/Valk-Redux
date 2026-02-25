function Valk.ui.create_UIBox_level_progress()
    local text_scale = 0.45
    local built = {
        n = G.UIT.ROOT,
        config = { colour = lighten(G.C.JOKER_GREY, 0.5), padding = 0.05, r = 0.02 },
        nodes = {
            {
                n = G.UIT.R,
                config = { colour = HEX("545D60"), r = 0.02, padding = 0.05 },
                nodes = {
                    Valk.ui.DynaBar({
                        ref_table = G.GAME.valk_leveling,
                        ref_value = "xp",
                        min = 0,
                        max = { ref_table = G.GAME.valk_leveling, ref_value = "req" },
                        w = 8,
                        h = 0.5
                    }),
                    {
                        n = G.UIT.C,
                        config = { minw = 1.25 },
                        nodes = {
                            {
                                n = G.UIT.R,
                                config = { align = "tr" },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = { text = localize("ph_lv_display"), scale = text_scale },
                                    },
                                    {
                                        n = G.UIT.T,
                                        config = { ref_table = G.GAME.valk_leveling, ref_value = "level_display", scale = text_scale },
                                    },
                                },
                            },
                            {
                                n = G.UIT.R,
                                config = { align = "tr" },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = { ref_table = G.GAME.valk_leveling, ref_value = "xp_display", scale = text_scale * 0.8 },
                                    },
                                    {
                                        n = G.UIT.T,
                                        config = { text = "/", scale = text_scale * 0.8 },
                                    },
                                    {
                                        n = G.UIT.T,
                                        config = { ref_table = G.GAME.valk_leveling, ref_value = "req_display", scale = text_scale * 0.8 },
                                    },
                                },
                            },
                        },
                    },
                },
            },

        }
    }

    return built
end

Valk.util.hook_after("Game.start_run", function(_, self, args)
    Valk.ui.refresh_level_progress()
end)

function Valk.ui.refresh_level_progress()
    if G.valk_level_progress then
        G.valk_level_progress:remove()
    end
    G.valk_level_progress = UIBox {
        definition = Valk.ui.create_UIBox_level_progress(),
        config = { major = G.jokers, offset = { x = 0, y = -3 }, align = "cm", instance_type = "POPUP" },
    }
end

Valk.leveling.easing = "outexpo"
Valk.leveling.easing_drop = "outcirc"
Valk.leveling.anim_runtime = 0.5
function Valk.leveling.drop_ui(skip_jokers)
    local time = Valk.leveling.anim_runtime
    local easing = Valk.leveling.easing_drop
    local multiplier = 1.5
    if not skip_jokers then
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ease = easing, --easing type
            ref_table = G.jokers.T,
            ref_value = "y",
            ease_to = -1.25,           --end value
            delay = time * multiplier, --time taken
            timer = "REAL",
            func = (function(t) return t end),
        }), "other")
    end

    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        ease = easing, --easing type
        ref_table = G.valk_level_progress.config.offset,
        ref_value = "y",
        ease_to = 2.1,             --end value
        delay = time * multiplier, --time taken
        timer = "REAL",
        func = (function(t) return t end),
    }))
end

function Valk.leveling.return_ui(skip_jokers)
    local time = Valk.leveling.anim_runtime
    local easing = Valk.leveling.easing
    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        ease = easing, --easing type
        ref_table = G.valk_level_progress.config.offset,
        ref_value = "y",
        ease_to = -3, --end value
        delay = time, --time taken
        timer = "REAL",
        func = (function(t) return t end),
    }))

    if not skip_jokers then
        G.E_MANAGER:add_event(Event({
            trigger = 'ease',
            ease = easing, --easing type
            ref_table = G.jokers.T,
            ref_value = "y",
            ease_to = 0, --end value
            delay = time, --time taken
            timer = "REAL",
            func = (function(t) return t end),
        }), "other")
    end
end

function Valk.leveling.full_ease_xp(amount, skip)
    G.E_MANAGER:add_event(Event({
        trigger = 'after',
        delay = 2,
        func = function()
            Valk.leveling.drop_ui(skip)
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 2,
                func = function()
                    Valk.leveling.ease_xp(amount)
                    G.E_MANAGER:add_event(Event({
                        trigger = 'after',
                        delay = 2,
                        blocking = false,
                        func = function()
                            if not G.GAME.valk_leveling.in_animation then
                                G.E_MANAGER:add_event(Event({
                                    trigger = 'after',
                                    delay = 2,
                                    func = function()
                                        Valk.leveling.return_ui(skip)
                                        return true
                                    end
                                }))
                                return true
                            end
                        end
                    }))
                    return true
                end
            }))

            return true
        end
    }))
end

-- idea:
--[[
level ui drops down after cashing out
does similar thing to cashout but more dramatic for sources of xp gain
eases xp gain based on that
level ui goes back up
]]

--[[
down state:
jokers.T.y = -1.2
level.offset.y = 2.1

base state:
jokers.T.y = 0
level.offset.y = -3
]]
