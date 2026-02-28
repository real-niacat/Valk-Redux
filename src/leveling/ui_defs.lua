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

function Valk.ui.create_UIBox_level_toggle()
    return {
        n = G.UIT.ROOT,
        config = { colour = lighten(G.C.JOKER_GREY, 0.5), padding = 0.05, r = 0.02 },
        nodes = {
            {
                n = G.UIT.R,
                config = { colour = HEX("545D60"), padding = 0.05, r = 0.02, minw = 1, minh = 1, align = "bm", hover = true, button = "level_toggle", button_dist = 0, },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = {
                            object = DynaText {
                                string = { { string = "^", colour = G.C.UI.TEXT_LIGHT } },
                                colour = G.C.UI.TEXT_LIGHT,
                                scale = 0.6,

                            }
                        },
                    },
                },
            },
        }
    }
end

function Valk.ui.create_UIBox_level_gate()
    local pad = 0.02
    return {
        n = G.UIT.ROOT,
        config = { colour = lighten(G.C.JOKER_GREY, 0.5), padding = 0.05, r = 0.02 },
        nodes = {
            {
                n = G.UIT.C,
                config = { padding = pad },
                nodes = {
                    {
                        n = G.UIT.R,
                        config = { colour = HEX("545D60"), r = 0.02, minw = 4, minh = 0.8, padding = pad, align = "cm" },
                        nodes = {
                            {
                                n = G.UIT.T,
                                config = { text = localize("ph_upcoming_gate"), scale = 0.6 },
                            },
                        },
                    },
                    {
                        n = G.UIT.R,
                        config = { padding = pad },
                        nodes = {
                            {
                                n = G.UIT.C,
                                config = { colour = HEX("545D60"), r = 0.02, minw = 2, minh = 0.7, padding = pad, align = "cm" },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = { text = localize("k_ante") .. " " .. Valk.leveling.get_next_gate(), scale = 0.6 },
                                    },
                                },
                            },
                            {
                                n = G.UIT.C,
                                config = {padding = pad},
                                nodes = {},
                            },
                            {
                                n = G.UIT.C,
                                config = { colour = HEX("545D60"), r = 0.02, minw = 2, minh = 0.7, padding = pad, align = "cm" },
                                nodes = {
                                    {
                                        n = G.UIT.T,
                                        config = { text = localize("k_level") .. " " .. Valk.leveling.calc_gate(Valk.leveling.get_next_gate()), scale = 0.6 },
                                    },
                                },
                            },
                        },
                    },
                },
            },
        }
    }
end

function G.FUNCS.level_toggle(e)
    -- print("blebleble")
    if G.GAME.valk_leveling.ui_state.complete then
        if G.GAME.valk_leveling.ui_state.type == "drop" and G.valk_gate_ui then
            Valk.leveling.return_ui()
            Valk.leveling.ease_destroy_gate_ui()
        elseif (G.GAME.valk_leveling.ui_state.type == "return" or G.GAME.valk_leveling.ui_state.type == nil) and (not G.valk_gate_ui) then
            Valk.leveling.drop_ui()
            Valk.leveling.create_ease_gate_ui()
        end
    end
end

Valk.util.hook_after("Game.start_run", function(_, self, args)
    Valk.ui.refresh_level_progress()
    Valk.ui.refresh_level_toggle()
end)

function Valk.ui.refresh_level_progress()
    if G.valk_level_progress then
        G.valk_level_progress:remove()
    end
    G.valk_level_progress = UIBox {
        definition = Valk.ui.create_UIBox_level_progress(),
        config = { major = G.jokers, offset = { x = 0, y = -3 }, align = "cm", instance_type = "CARD" },
    }
end

function Valk.ui.refresh_level_toggle()
    if G.valk_level_toggle then
        G.valk_level_toggle:remove()
    end
    G.valk_level_toggle = UIBox {
        definition = Valk.ui.create_UIBox_level_toggle(),
        config = { major = G.consumeables, offset = { x = 1, y = 0 }, align = "tl", instance_type = "CARD" },
    }
end
