SMODS.ConsumableType {
    key = "Planetoid",
    collection_rows = { 6, 6 },
    primary_colour = HEX("D3ECF4"),
    secondary_colour = HEX("508DA0"),
    shop_rate = 1,
    default = "c_valk_micrometeoroid",
}

SMODS.Atlas {
    path = "planetoids.png",
    key = "oid",
    px = 65, -- irregular!
    py = 79,
}

local planetoid_cards = {

    { pos = { x = 0, y = 0 }, hand = "High Card", key = "kerberos" },
    { pos = { x = 1, y = 0 }, hand = "Pair", key = "icarus" },
    { pos = { x = 3, y = 2 }, hand = "Two Pair", key = "miranda" },
    { pos = { x = 2, y = 0 }, hand = "Three of a Kind", key = "daedalus" },
    { pos = { x = 1, y = 2 }, hand = "Straight", key = "pan" },
    { pos = { x = 0, y = 2 }, hand = "Flush", key = "amalthea" },
    { pos = { x = 3, y = 0 }, hand = "Full House", key = "cardea" },
    { pos = { x = 4, y = 0 }, hand = "Four of a Kind", key = "eureka" },
    { pos = { x = 2, y = 2 }, hand = "Straight Flush", key = "despina" },
    { pos = { x = 1, y = 1 }, hand = "Five of a Kind", key = "tyche" },
    { pos = { x = 2, y = 1 }, hand = "Flush House", key = "artemis" },
    { pos = { x = 0, y = 1 }, hand = "Flush Five", key = "ixion" },
}

function Valk.content.times_used(consumable_key)
    return Spectrallib.safe_get(G.GAME, "consumeable_usage", consumable_key, "count") or 0
end

function Valk.content.hand_colour(level)
    return (level == 1 and G.C.UI.TEXT_DARK or G.C.HAND_LEVELS[math.min(7, level)])
end

for i, oid in ipairs(planetoid_cards) do
    SMODS.Consumable {
        key = oid.key,
        set = "Planetoid",
        atlas = "oid",
        pos = oid.pos,
        config = { extra = { hand = oid.hand } },
        cost = 4,
        loc_vars = function(self, info_queue, card)
            local hand = G.GAME.hands[card.ability.extra.hand]
            local used = Valk.content.times_used(self.key) + 1
            return {
                vars = {
                    hand.level,
                    localize(card.ability.extra.hand, "poker_hands"),
                    hand.l_chips * used,
                    hand.l_mult * used,
                    hand.l_chips,
                    hand.l_mult,
                    localize { type = "name_text", set = self.set, key = self.key },
                    colours = {
                        Valk.content.hand_colour(hand.level),
                    },
                },
            }
        end,
        use = function(self, card, area, copier)
            SMODS.upgrade_poker_hands {
                hands = { card.ability.extra.hand },
                level_up = Valk.content.times_used(self.key) + 1,
                from = card,
            }
        end,
        valk_artist = "mailingway",
    }
end
