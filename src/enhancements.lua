SMODS.Enhancement {
    key = "mirrored",
    atlas = "misc",
    pos = { x = 3, y = 6 },
    valk_artist = "mailingway",
}

-- copying seal, edition, rank and suit code

function Valk.content.update_mirrored(area)
    for _, card in pairs(area.cards) do
        card:calc_mirrored()
    end
end

function Card:calc_mirrored(source)
    if SMODS.has_enhancement(self, "m_valk_mirrored") then
        local left_card = self.area.cards[Valk.util.get_index(self) - 1]
        local right_card = self.area.cards[Valk.util.get_index(self) + 1]

        if left_card and left_card ~= source then
            left_card:calc_mirrored(self)
        end
        if right_card and right_card ~= source then
            right_card:calc_mirrored(self)
        end

        if right_card then
            self:set_seal(right_card.seal, true, true)
            self:set_edition(right_card.edition and right_card.edition.key, true, true)
            local right_suit = right_card.base.suit
            local right_value = right_card.base.value
            if right_suit ~= self.base.suit or right_value ~= self.base.value then
                SMODS.change_base(self, right_suit, right_value)
            end
        end
    end
end

--make it run when a card is moved
Valk.util.hook_after("Card.stop_drag", function(_, self)
    Valk.content.update_mirrored(self.area)
end)
