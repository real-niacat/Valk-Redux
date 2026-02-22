SMODS.Atlas {
    key = "tags",
    path = "tags.png",
    px = 34,
    py = 34,
}

SMODS.Tag {
    key = "kitty",
    atlas = "tags",
    pos = {x=0,y=0},
    in_pool = function(self, args)
        return false --only created by other things, doesn't spawn naturally
    end,
    loc_vars = function(self, info_queue, tag)
        return {vars = {G.GAME.kitty_tag_chips}}
    end
}

---@return number owned Kitty tags currently owned
function Valk.util.get_kitty_tags()
    local count = 0
    for _,tag in pairs(G.GAME.tags) do
        if tag.key == "tag_valk_kitty" then
            count = count + 1
        end
    end
    return count
end