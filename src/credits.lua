function Valk.ui.generate_artist_card(artist)
    local image = nil
    local imgsize = 1.2
    if artist.has_pfp then
        image = Sprite(0, 0, 1.25, 1.25, G.ASSET_ATLAS["valk_" .. artist.key .. "_img"], { x = 0, y = 0 })
    end

    return {
        n = G.UIT.R,
        config = { colour = adjust_alpha(G.C.BLACK, 0.3), padding = 0.05, r = 0.05, align = "cm" },
        nodes = {
            {
                n = G.UIT.C,
                config = { colour = lighten(G.C.BLACK, 0.1), padding = 0.05, r = 0.05, minw = 6.5 },
                nodes = {
                    -- pfp, name, desc
                    {
                        n = G.UIT.R,
                        config = {},
                        nodes = {
                            -- name
                            image
                                    and {
                                        n = G.UIT.C,
                                        config = { colour = G.C.WHITE, padding = 0.05, r = 0.01, align = "cm" },
                                        nodes = {
                                            {
                                                n = G.UIT.R,
                                                config = { r = 0.1, no_overflow = true, w = imgsize, h = imgsize, align = "cm" },
                                                nodes = {
                                                    {
                                                        n = G.UIT.O,
                                                        config = { object = image },
                                                    },
                                                },
                                            },
                                        },
                                    }
                                or nil,
                            --texts
                            {
                                n = G.UIT.C,
                                config = {},
                                nodes = {
                                    {
                                        n = G.UIT.R,
                                        config = { padding = 0.05 },
                                        nodes = {
                                            {
                                                n = G.UIT.T,
                                                config = { text = artist.display_name, scale = 0.5, shadow = true },
                                            },
                                        },
                                    },
                                    {
                                        n = G.UIT.R,
                                        config = { padding = 0.05 },
                                        nodes = {
                                            {
                                                n = G.UIT.T,
                                                config = { text = artist.description or "n/a", scale = 0.3 },
                                            },
                                        },
                                    },
                                    {
                                        n = G.UIT.R,
                                        config = { padding = 0.05 },
                                        nodes = {
                                            {
                                                n = G.UIT.C,
                                                config = { button = "valk_artist_cards", artist = artist.key, colour = G.C.GREEN, r = 0.005, minh = 0.3, minw = 1.2, align = "cm", button_dist = 0, padding = 0.05 },
                                                nodes = {
                                                    {
                                                        n = G.UIT.T,
                                                        config = { text = localize("k_valk_see_creations"), scale = 0.21 },
                                                    },
                                                },
                                            },
                                            artist.link
                                                    and {
                                                        n = G.UIT.C,
                                                        config = { button = "valk_artist_link", goto_link = artist.link, colour = G.C.GREEN, r = 0.005, minh = 0.3, minw = 1.2, align = "cm", button_dist = 0, padding = 0.05 },
                                                        nodes = {
                                                            {
                                                                n = G.UIT.T,
                                                                config = { text = localize("k_valk_social_media"), scale = 0.21 },
                                                            },
                                                        },
                                                    }
                                                or nil,
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
end

function G.FUNCS.valk_artist_cards(e)
    local cards = Valk.artists[e.config.artist].drawn
    local centers = {}
    for k, v in pairs(cards) do
        centers[k] = G.P_CENTERS[v]
    end
    table.sort(centers, function(a, b)
        if a.set ~= b.set then
            return a.set < b.set
        end
        if a.rarity ~= b.rarity then
            return tostring(a.rarity) < tostring(b.rarity)
        end
        return a.key < b.key
    end)
    G.E_MANAGER:add_event(Event {
        trigger = "after",
        func = function()
            G.FUNCS.overlay_menu {
                definition = SMODS.card_collection_UIBox(centers, { 5, 5, 5 }, {
                    back_func = "openModUI_valkredux",
                    modify_card = function(card, center, i, j)
                        if center.set == "Edition" then
                            card:set_edition(center.key, true, true)
                        end
                    end,
                }),
            }
            return true
        end,
    })
end

function G.FUNCS.valk_artist_link(e)
    love.system.openURL(e.config.goto_link)
end

Valk.ui.artists_per_page = 3

function Valk.ui.generate_artist_cards(page)
    page = page - 1
    table.sort(Valk.i_artists, function(a, b)
        return #a.drawn > #b.drawn
    end)
    local artists_per_page = Valk.ui.artists_per_page
    local t = {}
    local first = (artists_per_page * page) + 1
    local last = first + (artists_per_page - 1)
    for i = first, last do
        table.insert(t, Valk.ui.generate_artist_card(Valk.i_artists[i]))
    end

    return t
end

function Valk.ui.generate_internal(page, parent)
    return UIBox {
        definition = {
            n = G.UIT.ROOT,
            config = { colour = lighten(G.C.JOKER_GREY, 0.5), padding = 0.05, r = 0.01 },
            nodes = {
                {
                    n = G.UIT.C,
                    config = {},
                    nodes = Valk.ui.generate_artist_cards(page),
                },
            },
        },
        config = {
            parent = parent,
            align = "cm",
        },
    }
end

function Valk.ui.credits_def()
    local function gen_opts()
        local pages = math.ceil(#Valk.i_artists / Valk.ui.artists_per_page)
        local r = {}
        local page = localize("k_valk_page")
        for i = 1, pages do
            table.insert(r, page .. i)
        end
        return r
    end
    return {
        n = G.UIT.ROOT,
        config = { r = 0.05, padding = 0.1, colour = G.C.BLACK },
        nodes = {
            {
                n = G.UIT.R,
                config = { align = "cm" },
                nodes = {
                    {
                        n = G.UIT.O,
                        config = { id = "credits", object = Valk.ui.generate_internal(1), align = "cm" },
                        nodes = {},
                    },
                },
            },
            create_option_cycle {
                options = gen_opts(),
                current_option = 1,
                opt_callback = "valk_update_pages",
            },
        },
    }
end

function G.FUNCS.valk_update_pages(args)
    local page = args.to_key
    local ref = G.OVERLAY_MENU:get_UIE_by_ID("credits")
    ref.config.object:remove()
    ref.config.object = Valk.ui.generate_internal(page, ref)

    ref.config.object:recalculate()
    G.OVERLAY_MENU:recalculate()
end
