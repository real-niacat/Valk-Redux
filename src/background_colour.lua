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
        HEX("50FFC5")
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

Valk.util.hook_after("Game.main_menu", function()
    G.C.valk_bg_prim = gradient_1
    G.C.valk_bg_sec = gradient_2
    G.SPLASH_BACK:define_draw_steps({
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", val = 0.4 },
                { name = "colour_1",   ref_table = G.C,      ref_value = "valk_bg_prim" },
                { name = "colour_2",   ref_table = G.C,      ref_value = "valk_bg_sec" },
            },
        },
    })

    G.E_MANAGER:add_event(Event({
        trigger = 'ease',
        ease = "insine",         --easing type
        ref_table = G.title_top.T,
        ref_value = "y",
        ease_to = 2.4,         --end value
        delay = 2,             --time taken
        timer = "REAL",
        func = (function(t) return t end),
    }))
end)
