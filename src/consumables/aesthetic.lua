SMODS.ConsumableType {
    key = "Aesthetic",
    collection_rows = { 5, 5 },
    primary_colour = HEX("F1B7FF"),
    secondary_colour = HEX("DCA0FF"),
    shop_rate = 0.4,
    -- default = "c_valk_",
}

local aesthetic_cards = {

    { pos = { x = 0, y = 0 }, key = "e_foil", name = "frutiger_aero", artist = "pangaea" },
    { pos = { x = 1, y = 0 }, key = "e_holo", name = "synthwave", artist = "pangaea" },
    { pos = { x = 2, y = 0 }, key = "e_polychrome", name = "chromecore", artist = "pangaea" },
    { pos = { x = 3, y = 0 }, key = "e_negative", name = "vaporwave", artist = "pangaea" },
    { pos = { x = 0, y = 3 }, key = "e_valk_rgb", name = "scene", artist = "slipstream" },
    { pos = { x = 1, y = 3 }, key = "e_valk_cosmic", name = "memphis", artist = "slipstream" },
    { pos = { x = 2, y = 3 }, key = "e_valk_glow", name = "arcadecore", artist = "slipstream" },
    { pos = { x = 3, y = 3 }, key = "e_valk_lordly", name = "savior", artist = "pangaea", hidden = true, soul_rate = 0.02 },
    { pos = { x = 4, y = 3 }, key = "e_valk_censored", name = "cl___ified", artist = "mailingway" },
}

for i, aesthetic in ipairs(aesthetic_cards) do
    SMODS.Consumable {
        set = "Aesthetic",
        key = aesthetic.name,
        cost = 6,
        atlas = "aesthetic",
        pos = aesthetic.pos,
        config = { extra = { cards = 1, edition = aesthetic.key } },
        loc_vars = function(self, info_queue, card)
            info_queue[#info_queue + 1] = G.P_CENTERS[card.ability.extra.edition]
            return {
                vars = {
                    card.ability.extra.cards,
                    localize { type = "name_text", set = "Edition", key = card.ability.extra.edition },
                },
                key = "c_valk_aesthetic_base",
                name_key = self.key,
            }
        end,
        hidden = aesthetic.hidden,
        soul_rate = aesthetic.soul_rate,
        can_use = function(self, card)
            local highlighted = Spectrallib.get_highlighted_cards({ G.jokers, G.hand }, card, 1, card.ability.extra.cards, function(c)
                return not c.edition
            end)
            return (#highlighted > 0) and (#highlighted <= card.ability.extra.cards)
        end,
        use = function(self, card, area, copier)
            for _, high in
                ipairs(Spectrallib.get_highlighted_cards({ G.jokers, G.hand }, card, 1, card.ability.extra.cards, function(c)
                    return not c.edition
                end))
            do
                high:set_edition(card.ability.extra.edition)
            end
        end,
        valk_artist = aesthetic.artist,
    }
end
