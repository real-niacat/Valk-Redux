--[[
G.SPLASH_BACK:define_draw_steps({ -- meow?
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", ref_table = aquill,   ref_value = "bg_speed" },
                { name = "colour_1",   ref_table = G.C,      ref_value = "aqu_bg_prim" },
                { name = "colour_2",   ref_table = G.C,      ref_value = "aqu_bg_sec" },
            },
        },
})]]

local gradient_1 = SMODS.Gradient {
    key = "grad1",
    colours = {
        HEX("5087FF"),
        HEX("50FFC5"),
    },
    cycle = 9,
}

local gradient_2 = SMODS.Gradient {
    key = "grad2",
    colours = {
        HEX("B6C7FF"),
        HEX("B486FF"),
    },
    cycle = 8,
}

SMODS.Gradient {
    key = "evil",
    colours = {
        HEX("B10000"),
        HEX("B87575"),
    },
    cycle = 5,
}

SMODS.Atlas {
    key = "menu_logo",
    path = "valk_redux_logo_trimmed.png",
    px = 335,
    py = 102,
}

Valk.util.hook_after("Game.main_menu", function()
    G.C.valk_prim = gradient_1
    G.C.valk_sec = gradient_2
    G.SPLASH_BACK:define_draw_steps {
        {
            shader = "splash",
            send = {
                { name = "time", ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 0.4 },
                { name = "colour_1", ref_table = G.C, ref_value = "valk_prim" },
                { name = "colour_2", ref_table = G.C, ref_value = "valk_sec" },
            },
        },
    }

    -- logo HEAVILY inspired by Maximus, go check it out!
    local atlas = G.ASSET_ATLAS["valk_menu_logo"]
    local scale = 1.6
    G.VALK_LOGO = Sprite(0, 0, 6 * scale, 6 * scale * (atlas.py / atlas.px), atlas, { x = 0, y = 0 })

    G.E_MANAGER:add_event(
        Event {
            trigger = "after",
            func = function()
                -- this is treated as basically "wait until X, then run Y code"
                -- i really love the event queue for this reason
                if G.MAIN_MENU_UI then
                    G.VALK_LOGO:set_alignment {
                        major = G.MAIN_MENU_UI,
                        type = "cm",
                        bond = "Strong",
                        offset = { x = -1, y = -2.5 },
                    }
                    G.VALK_LOGO.aligned_to_menu = true
                    return true
                end
            end,
        },
        "valk_2"
    )

    G.VALK_LOGO:define_draw_steps { {
        shader = "dissolve",
    } }

    -- Define logo properties
    G.VALK_LOGO.tilt_var = { mx = 0, my = 0, dx = 0, dy = 0, amt = 0 }
    G.VALK_LOGO.dissolve_colours = { G.C.valk_prim, G.C.valk_sec }
    G.VALK_LOGO.dissolve = 1
    G.VALK_LOGO.states.collide.can = true
    function G.VALK_LOGO:hover()
        G.VALK_LOGO:juice_up(0.05, 0.03)
        Node.hover(self)
    end

    function G.VALK_LOGO:stop_hover()
        Node.stop_hover(self)
    end

    G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 0,
        timer = "REAL",
        func = function()
            G.E_MANAGER:add_event(Event {
                trigger = "ease",
                ease = "insine", --easing type
                ref_table = G.title_top.T,
                ref_value = "y",
                ease_to = 2.4, --end value
                delay = 2, --time taken
                timer = "REAL",
                func = function(t)
                    return t
                end,
            })
            return true
        end,
    })
    G.E_MANAGER:add_event(Event {
        trigger = "after",
        delay = 1,
        timer = "REAL",
        func = function()
            if G.VALK_LOGO.aligned_to_menu then
                G.E_MANAGER:add_event(
                    Event {
                        trigger = "ease",
                        ease = "insine", --easing type
                        ref_table = G.VALK_LOGO,
                        ref_value = "dissolve",
                        ease_to = 0, --end value
                        delay = 2, --time taken
                        timer = "REAL",
                        func = function(t)
                            return t
                        end,
                    },
                    "valk_1"
                )
                return true
            end
        end,
    })
end)
