SMODS.Tag {
    key = "kitty",
    atlas = "tags",
    pos = { x = 0, y = 0 },
    in_pool = function(self, args)
        return false --only created by other things, doesn't spawn naturally
    end,
    loc_vars = function(self, info_queue, tag)
        return { vars = { G.GAME.kitty_tag_chips } }
    end,
}

---@return number owned Kitty tags currently owned
function Valk.util.get_kitty_tags()
    local count = 0
    for _, tag in pairs(G.GAME.tags) do
        if tag.key == "tag_valk_kitty" then
            count = count + 1
        end
    end
    return count
end

SMODS.Tag {
    key = "negative_eternal",
    atlas = "tags",
    pos = { x = 1, y = 0 },
    apply = function(self, tag, context)
        -- mostly copied from VanillaRemade
        -- we love you N'
        if context.type == "store_joker_modify" then
            if not context.card.edition and not context.card.temp_edition and context.card.ability.set == "Joker" then
                local lock = tag.ID
                G.CONTROLLER.locks[lock] = true
                context.card.temp_edition = true
                tag:yep("+", G.C.DARK_EDITION, function()
                    context.card.temp_edition = nil
                    context.card:set_edition("e_negative", true)
                    context.card:set_eternal(true)
                    context.card.ability.couponed = true
                    context.card:set_cost()
                    G.CONTROLLER.locks[lock] = nil
                    return true
                end)
                tag.triggered = true
                return true
            end
        end
    end,
}
