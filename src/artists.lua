Valk.artists = {}
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
        SMODS.GameObject.register(self)
    end,
}

Valk.artist {
    key = "mailingway",
    display_name = "mailingway",
    other_names = { "Patchy" },
}

Valk.artist {
    key = "pangaea",
    display_name = "Pangaea47",
}

Valk.artist {
    key = "scraptake",
    display_name = "Scraptake",
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
}

Valk.artist {
    key = "duck",
    display_name = "Aduckted",
}

Valk.util.hook_after("SMODS.injectItems", function()
    for _, center in pairs(G.P_CENTERS) do
        if center.valk_artist then
            table.insert(Valk.artists[center.valk_artist].drawn, center.key)
        end
    end
end)
