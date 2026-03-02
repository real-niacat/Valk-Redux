function Valk.ui.get_value(tab)
    return tab.ref_table and tab.ref_table[tab.ref_value] or tab.value
end

function Valk.ui.DynaBar(args)
    args = args or {}
    args.colour = args.colour or G.C.RED
    args.inactive_colour = args.inactive_colour or G.C.BLACK
    args.w = args.w or 1
    args.h = args.h or 0.5
    args.label_scale = args.label_scale or 0.5
    args.text_scale = args.text_scale or 0.3
    if type(args.min) == "number" then
        args.min = { value = args.min }
    end
    if type(args.max) == "number" then
        args.max = { value = args.max }
    end
    args.decimal_places = args.decimal_places or 0
    local startval = args.w * (args.ref_table[args.ref_value] - Valk.ui.get_value(args.min)) / (Valk.ui.get_value(args.max) - Valk.ui.get_value(args.min))

    local t = {
        n = G.UIT.C,
        config = { align = "cm", minw = args.w, min_h = args.h, padding = 0.1, r = 0.1, colour = G.C.CLEAR },
        nodes = {
            {
                n = G.UIT.C, -- update_bar runs every frame and properly sets the box's width in lieu of actual slider interactivity
                config = {
                    align = "cl",
                    minw = args.w,
                    r = 0.1,
                    min_h = args.h,
                    colour = args.inactive_colour or G.C.BLACK,
                    emboss = 0.05,
                    refresh_movement = true,
                    update_func = "update_bar",
                },
                nodes = {
                    {
                        n = G.UIT.B,
                        config = {
                            w = startval,
                            h = args.h,
                            r = 0.1,
                            colour = args.colour,
                            ref_table = args,
                            refresh_movement = true,
                            shader = args.fill_shader,
                        },
                    },
                },
            },
        },
    }
    return t
end

function G.FUNCS.update_bar(e)
    local c = e.children[1]
    local rt = c.config.ref_table
    rt.text = (rt.ref_table[rt.ref_value] - Valk.ui.get_value(rt.min)) / (Valk.ui.get_value(rt.max) - Valk.ui.get_value(rt.min)) * rt.w
    c.T.w = (rt.ref_table[rt.ref_value] - Valk.ui.get_value(rt.min)) / (Valk.ui.get_value(rt.max) - Valk.ui.get_value(rt.min)) * rt.w
    c.config.w = c.T.w
end

Valk.util.hook_before("UIElement.update", function(original, self, dt)
    if self.config and self.config.update_func then
        G.FUNCS[self.config.update_func](self)
    end
end)

function Valk.ui.generate_tooltip(tooltip)
    local title = tooltip.title or nil
    local text = tooltip.text or {}
    local rows = {}
    if title then
        local r = {
            n = G.UIT.R,
            config = { align = "cm" },
            nodes = {
                {
                    n = G.UIT.C,
                    config = { align = "cm" },
                    nodes = {
                        { n = G.UIT.T, config = { text = title, colour = G.C.UI.TEXT_DARK, scale = 0.4 } },
                    },
                },
            },
        }
        table.insert(rows, r)
    end
    for i = 1, #text do
        if type(text[i]) == "table" then
            local r = {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.03 },
                nodes = {
                    { n = G.UIT.T, config = { ref_table = text[i].ref_table, ref_value = text[i].ref_value, colour = G.C.UI.TEXT_DARK, scale = 0.4 } },
                },
            }
            table.insert(rows, r)
        else
            local r = {
                n = G.UIT.R,
                config = { align = "cm", padding = 0.03 },
                nodes = SMODS.localize_box(loc_parse_string(text[i]), { scale = 1 }),
            }
            table.insert(rows, r)
        end
    end
    if tooltip.filler then
        table.insert(rows, tooltip.filler.func(tooltip.filler.args))
    end
    local t = {
        n = G.UIT.ROOT,
        config = { align = "cm", padding = 0.05, r = 0.1, colour = G.C.L_BLACK, emboss = 0.01 },
        nodes = { { n = G.UIT.C, config = { align = "cm", padding = 0.05, r = 0.1, colour = G.C.WHITE, emboss = 0.01 }, nodes = rows } },
    }
    return t
end
