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
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                echips = card.edition.echips,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.echips } }
    end,
    config = { echips = 1.05 },
    extra_cost = 3,
    weight = 5,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
}

SMODS.Edition {
    key = "rgb",
    shader = "rgb",
    calculate = function(self, card, context)
        if context.pre_joker or (context.main_scoring and context.cardarea == G.play) then
            return {
                chips = card.edition.chips,
                xmult = card.edition.xmult,
            }
        end
    end,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.edition.chips, card.edition.xmult } }
    end,
    config = { chips = 25, xmult = 1.25 },
    extra_cost = 3,
    weight = 8,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
}

SMODS.Edition {
    key = "glow",
    shader = "glow",
    calculate = function(self, card, context)
        if (context.post_trigger and context.other_card == card) or (context.main_scoring and context.cardarea == G.play) then
            card:juice_up()
            local sets = { "Planet", "Tarot" }
            if next(SMODS.find_card("j_valk_arkade")) then
                table.insert(sets, "Spectral")
            end
            local chosen = Valk.util.poll_sets(sets, "valk_glowdark")
            SMODS.add_card { key = chosen, area = G.consumeables }
        end
    end,
    extra_cost = 12,
    weight = 4,
    valk_artist = "lily",
    valk_art_type = "k_valk_shaderby",
}
