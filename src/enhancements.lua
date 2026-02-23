SMODS.Enhancement {
    key = "mirrored",
    atlas = "misc",
    pos = { x = 3, y = 6 },
}

-- copying seal, edition, rank and suit code

function Valk.content.update_mirrored(area)
    for _, card in pairs(area.cards) do
        if SMODS.has_enhancement(card, "m_valk_mirrored") then
            local right_card = card.area.cards[Valk.util.get_index(card) + 1]
            if not right_card then
                return
            end
            card:set_seal(right_card.seal, true, true)
            card:set_edition(right_card.edition and right_card.edition.key, true, true)
            SMODS.change_base(card, right_card.base.suit, right_card.base.value)

            -- local key = right_card.config.center.key
            -- if key == "c_base" then
            --     key = "m_valk_mirrored"
            -- end
            -- local center = G.P_CENTERS[key]
            -- card.children.center.atlas = G.ASSET_ATLAS[center.atlas or "centers"]
            -- card.children.center:set_sprite_pos(center.pos)
            -- card.children.center:reset()
        end
    end
end

--make it run when a card is moved
Valk.util.hook_after("Card.stop_drag", function(_, self)
    Valk.content.update_mirrored(self.area)
end)

-- Valk.util.hook("SMODS.get_enhancements", function(get_enhancements, card)
--     local original_return = get_enhancements(card)
--     local right_card = card.area.cards[Valk.util.get_index(card) + 1]
--     if original_return["m_valk_mirrored"] and right_card then
--         return Valk.util.merge_tables(original_return, get_enhancements(right_card))
--     end
--     return original_return
-- end)