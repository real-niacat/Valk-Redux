Valk.util.hook("Game.init_game_object", function(original, ...)
    local game = original(...)
    game.kitty_tag_chips = 2
    return game
end)