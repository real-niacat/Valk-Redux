SMODS.Rarity {
    key = "renowned",
    default_weight = 0.025,
    badge_colour = SMODS.Gradient {
        key = "renowned_gradient",
        colours = {
            HEX("DA61FF"),
            HEX("FF90E3"),
            HEX("6461FF"),
        },
        cycle = 5,
    }
}

SMODS.Joker {
    key = "imwithstupid",
    atlas = "jokers",
    pos = {x=6,y=3},
    config = {extra = {retriggers = 0, retrigger_gain = 1, cards_required = 20, cards_left = 20}},
    rarity = "valk_renowned",
    cost = 11,
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra.retriggers,
            card.ability.extra.retrigger_gain,
            card.ability.extra.cards_required,
            card.ability.extra.cards_left
        }}
    end,
    calculate = function(self, card, context)
        -- code here
        if context.individual and context.cardarea == G.play then
            card.ability.extra.cards_left = card.ability.extra.cards_left - 1
            if card.ability.extra.cards_left <= 0 then
                SMODS.scale_card(card, {ref_table = card.ability.extra, ref_value = "retriggers", scalar_value = "retrigger_gain"})
                card.ability.extra.cards_left = card.ability.extra.cards_required
            end
        end

        if context.retrigger_joker_check and Valk.util.get_index(context.other_card) == Valk.util.get_index(card)-1 and card.ability.extra.retriggers > 0 then
            return {repetitions = card.ability.extra.retriggers}
        end
    end,
}