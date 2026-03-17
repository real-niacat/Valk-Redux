Valk.artists = {}
Valk.i_artists = {}
Valk.artist = SMODS.GameObject:extend {
    required_params = {
        "key",
        "display_name",
    },
    obj_table = Valk.artists,
    prefix_config = {
        key = false,
    },
    register = function(self)
        self.drawn = {}
        local imgs = SMODS.NFS.getDirectoryItems(Valk.mod.path .. "/assets/1x")
        for _, name in ipairs(imgs) do
            if name == self.key .. ".png" then
                self.has_pfp = true
                SMODS.Atlas {
                    key = self.key .. "_img",
                    path = self.key .. ".png",
                    px = 128,
                    py = 128,
                }
            end
        end

        table.insert(Valk.i_artists, self)
        SMODS.GameObject.register(self)
    end,
}

Valk.artist {
    key = "mailingway",
    display_name = "mailingway",
    description = "I Love Mulch! Mulch is my Life!",
}

Valk.artist {
    key = "pangaea",
    display_name = "Pangaea47",
    description = "residential spider, good at art",
}

Valk.artist {
    key = "scraptake",
    display_name = "Scraptake",
    link = "https://bsky.app/profile/scraptake.bsky.social",
}

Valk.artist {
    key = "triangle_snack",
    display_name = "triangle_snack",
}

Valk.artist {
    key = "slipstream",
    display_name = "Lil Mr. Slipstream",
}

Valk.artist {
    key = "grahkon",
    display_name = "Grahkon",
    link = "https://www.reddit.com/user/apothioternity/",
    description = "Unknown creacher, sprite artist",
}

Valk.artist {
    key = "duck",
    display_name = "Aduckted",
}

Valk.artist {
    key = "ruby",
    display_name = "lord.ruby",
    link = "https://bsky.app/profile/lordruby.bsky.social",
    description = "i can tank any attack",
}

Valk.artist {
    key = "lily",
    display_name = "Ophelia",
    link = "https://en.pronouns.page/@lily.felli",
    description = "Trans girl, shadermaker, developer",
}

Valk.artist {
    key = "notmario",
    display_name = "notmario.",
    description = "i make stupid things",
}

Valk.util.hook_after("SMODS.injectItems", function()
    for _, center in pairs(G.P_CENTERS) do
        if center.valk_artist then
            table.insert(Valk.artists[center.valk_artist].drawn, center.key)
        end
    end
end)

function Valk.util.art_percentages()
    local total = 0
    local counts = {}
    for _, artist in ipairs(Valk.i_artists) do
        local c = #artist.drawn
        counts[artist.key] = c
        total = total + c
    end

    for _, artist in ipairs(Valk.i_artists) do
        print(artist.display_name, tostring((counts[artist.key] / total) * 100) .. "%")
    end
end
