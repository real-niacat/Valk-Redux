Valk.util.hook("Game.init_game_object", function(original, ...)
    local game = original(...)
    game.kitty_tag_chips = 9
    game.jokers_owned = {}
    game.blind_size_multiplier = 1
    return game
end)

Valk.util.hook("get_blind_amount", function(original, ante)
    return original(ante) * G.GAME.blind_size_multiplier
end)
