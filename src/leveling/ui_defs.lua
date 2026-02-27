function Valk.ui.create_UIBox_level_progress()
    local text_scale = 0.45
    local xp_scale = 0.8
    local built = {
        n = G.UIT.ROOT,
        config = { colour = lighten(G.C.JOKER_GREY, 0.5), padding = 0.05, r = 0.02 },
        nodes = {
            {
                n = G.UIT.C,
                config = {},
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
                                h = 0.5,
                                colour = G.C.valk_prim
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
                                                config = { text = localize("ph_lv_display"), scale = text_scale, id = "level_text" },
                                            },
                                            {
                                                n = G.UIT.T,
                                                config = { ref_table = G.GAME.valk_leveling, ref_value = "level_display", scale = text_scale, id = "level_display" },
                                            },
                                        },
                                    },
                                    {
                                        n = G.UIT.R,
                                        config = { align = "tr" },
                                        nodes = {
                                            {
                                                n = G.UIT.T,
                                                config = { ref_table = G.GAME.valk_leveling, ref_value = "xp_display", scale = text_scale * xp_scale, id = "xp_display" },
                                            },
                                            {
                                                n = G.UIT.T,
                                                config = { text = "/", scale = text_scale * xp_scale },
                                            },
                                            {
                                                n = G.UIT.T,
                                                config = { ref_table = G.GAME.valk_leveling, ref_value = "req_display", scale = text_scale * xp_scale, id = "req_display" },
                                            },
                                        },
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