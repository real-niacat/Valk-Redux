SMODS.Shader {
    key = "cosmic",
    path = "cosmic.fs",
    send_vars = function(self, sprite, card)
        return {
            screen_size = { love.graphics.getWidth(), love.graphics.getHeight() },
        }
    end,
}

SMODS.Shader {
    key = "glow",
    path = "glow.fs",
}

SMODS.Shader {
    key = "rgb",
    path = "rgb.fs",
}

SMODS.Edition {
    key = "cosmic",
    shader = "cosmic",
    calculate = function(self, card, context) end,
}

SMODS.Edition {
    key = "glow",
    shader = "glow",
    calculate = function(self, card, context) end,
}

SMODS.Edition {
    key = "rgb",
    shader = "rgb",
    calculate = function(self, card, context) end,
}
