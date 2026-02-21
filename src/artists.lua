Valk.artists = {}
Valk.artist = SMODS.GameObject:extend {
    required_params = {
        "key",
        "display_name",
    },
    obj_table = Valk.artists,
    prefix_config = {
        key = false
    }
}

Valk.artist {
    key = "mailingway",
    display_name = "Mailingway",
    links = {"imagine link here"}
}