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

Valk.util.hook_after("Game.main_menu", function()
    G.C.valk_bg_prim = HEX("5087FF")
    G.C.valk_bg_sec = HEX("B6C7FF")
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
end)
