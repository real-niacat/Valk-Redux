SMODS.Joker {
    key = "planetarium",
    atlas = "jokers",
    pos = { x = 5, y = 2 },
    config = { extra = { upgrade = 3 } },
    rarity = 3,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.upgrade } }
    end,
    calculate = function(self, card, context)
        -- TODO: add animation
        if context.before and G.GAME.current_round.hands_left == G.GAME.round_resets.hands - 1 then
            local hand = G.GAME.hands[context.scoring_name]
            hand.l_chips = hand.l_chips + card.ability.extra.upgrade
            hand.l_mult = hand.l_mult + card.ability.extra.upgrade
        end
    end,
    valk_artist = "grahkon",
}

SMODS.Joker {
    key = "familiar_face",
    atlas = "jokers",
    pos = { x = 6, y = 2 },
    config = { extra = { xmult = 1.45, mul = 2 } },
    rarity = 3,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.xmult, ((card.ability.extra.xmult - 1) * card.ability.extra.mul) + 1 } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play then
            local nine = context.other_card:get_id() == 9
            local enhanced = next(SMODS.get_enhancements(context.other_card))
            if nine and enhanced then
                return { xmult = ((card.ability.extra.xmult - 1) * card.ability.extra.mul) + 1 }
            elseif nine or enhanced then
                return { xmult = card.ability.extra.xmult }
            end
        end
    end,
    valk_artist = "duck",
}

SMODS.Joker {
    key = "neffy",
    atlas = "jokers",
    pos = { x = 7, y = 2 },
    config = { extra = { base = 3, loss = 0.5 } },
    rarity = 3,
    cost = 5,
    loc_vars = function(self, info_queue, card)
        return {
            vars = {
                card.ability.extra.base - ((Valk.util.get_kitty_jokers() - 1) * card.ability.extra.loss),
                card.ability.extra.loss
            }
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.joker_main then
            return { xmult = card.ability.extra.base - ((Valk.util.get_kitty_jokers() - 1) * card.ability.extra.loss) }
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "box_of_kittens",
    atlas = "jokers",
    pos = { x = 8, y = 2 },
    config = { extra = {} },
    rarity = 3,
    cost = 9,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.reroll_shop then
            add_tag(Tag("tag_valk_kitty"))
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "dupliCation",
    atlas = "jokers",
    pos = { x = 9, y = 2 },
    config = { extra = { base_den = 3, den_increase = 1, den_req = 3, base_destroy = 5 } },
    rarity = 3,
    cost = 4,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        local cn, cd = SMODS.get_probability_vars(card, 1, self:get_denominator(card))
        local dn, dd = SMODS.get_probability_vars(card, 1, card.ability.extra.base_destroy)
        return {
            vars = {
                cn, cd,
                card.ability.extra.den_increase,
                card.ability.extra.den_req,
                dn, dd,
            }
        }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.end_of_round and context.main_eval then
            local d = self:get_denominator(card)
            local to_add = 0
            for _, tag in pairs(G.GAME.tags) do
                if (tag.key == "tag_valk_kitty") and SMODS.pseudorandom_probability(card, "kittydupe", 1, d) then
                    to_add = to_add + 1
                end
            end
            local to_remove = {}
            for _, tag in pairs(G.GAME.tags) do
                if (tag.key == "tag_valk_kitty") and SMODS.pseudorandom_probability(card, "kittydupe", 1, card.ability.extra.base_destroy) then
                    table.insert(to_remove, tag)
                end
            end

            for i = 1, to_add do
                add_tag(Tag("tag_valk_kitty"))
            end

            for _, remove_tag in pairs(to_remove) do
                remove_tag:remove()
            end
        end
    end,
    get_denominator = function(self, card)
        return card.ability.extra.base_den +
        (math.floor(Valk.util.get_kitty_tags() / card.ability.extra.den_req) * card.ability.extra.den_increase)
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "greedy_bastard",
    atlas = "jokers",
    pos = { x = 0, y = 3 },
    config = { extra = { xmult = 1, gain = 0.1 } },
    rarity = 3,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        info_queue[#info_queue + 1] = G.P_TAGS.tag_valk_kitty
        return { vars = { card.ability.extra.gain, card.ability.extra.xmult } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.end_of_round and context.main_eval then
            local to_remove = {}
            for _, tag in pairs(G.GAME.tags) do
                if (tag.key == "tag_valk_kitty") then
                    table.insert(to_remove, tag)
                end
            end

            for _, remove_tag in pairs(to_remove) do
                remove_tag:remove()
                SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "xmult", scalar_value = "gain" })
            end
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "one_million_beavers",
    atlas = "jokers",
    pos = { x = 2, y = 3 },
    config = { extra = { money = 20 } },
    rarity = 3,
    cost = 7,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.money } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.end_of_round and context.main_eval and context.game_over then
            G.E_MANAGER:add_event(Event({
                trigger = 'immediate',
                func = function()
                    ease_dollars(card.ability.extra.money)
                    return true
                end
            }))
            return {
                message = localize("k_saved_ex"),
                saved = "ph_beavers"
            }
        end
    end,
    valk_artist = "mailingway",
}

SMODS.Joker {
    key = "borderline",
    atlas = "jokers",
    pos = { x = 3, y = 3 },
    config = { extra = { chips = 0, chips_gain = 5 } },
    rarity = 3,
    cost = 6,
    loc_vars = function(self, info_queue, card)
        return { vars = { card.ability.extra.chips_gain, card.ability.extra.chips } }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play and context.other_card:is_suit("Clubs") then
            SMODS.scale_card(card, { ref_table = card.ability.extra, ref_value = "chips", scalar_value = "chips_gain" })
        end

        if context.joker_main then
            return { chips = card.ability.extra.chips }
        end
    end,
    valk_artist = "mailingway",
}

Valk.util.hook_after("love.draw", function()
    if next(SMODS.find_card("j_valk_borderline")) then
        local width = 10
        local screen = {
            width = love.graphics.getWidth(),
            height = love.graphics.getHeight()
        }
        love.graphics.push()
        love.graphics.setColor(HEX("3B57FF"))
        love.graphics.rectangle("fill", 0, 0, width, screen.height)
        love.graphics.rectangle("fill", 0, 0, screen.width, width)
        love.graphics.rectangle("fill", screen.width - width, 0, width, screen.height)
        love.graphics.rectangle("fill", 0, screen.height - width, screen.width, width)
        love.graphics.pop()
    end
end)

SMODS.Joker {
    key = "copycat",
    atlas = "jokers",
    pos = { x = 4, y = 3 },
    config = { extra = {} },
    rarity = 3,
    cost = 8,
    loc_vars = function(self, info_queue, card)
        return { vars = {} }
    end,
    calculate = function(self, card, context)
        -- code here
        if context.setting_blind then
            local mirrored = SMODS.add_card({ set = "Base", enhancement = "m_valk_mirrored", area = G.discard })
            G.playing_card = G.playing_card and (G.playing_card + 1) or 1
            mirrored.playing_card = G.playing_card
            table.insert(G.playing_cards, mirrored)
            return {
                message = localize("k_created"),
                colour = G.C.SECONDARY_SET.Enhanced,
                func = function()
                    SMODS.calculate_context({ playing_card_added = true, cards = { mirrored } })
                end
            }
        end
    end,
    valk_artist = "mailingway",
}
