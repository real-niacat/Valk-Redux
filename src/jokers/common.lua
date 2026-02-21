SMODS.Joker {
    key = "suck_it",
    atlas = "jokers",
    pos = {x=2,y=0},
    config = {extra = {lossden = 8, loss = 5, gainden = 15, gain = 20}},
    rarity = 1,
    loc_vars = function(self, info_queue, card)
        local ln,ld = SMODS.get_probability_vars(card, 1, card.ability.extra.lossden)
        local gn,gd = SMODS.get_probability_vars(card, 1, card.ability.extra.gainden)
        return {vars = {
            ln,
            ld,
            card.ability.extra.loss,
            gn,
            gd,
            card.ability.extra.gain,
        }}
    end,
    calculate = function(self, card, context)
        if context.selling_self then
            local loss = SMODS.pseudorandom_probability(card, "suck_it_loss", 1, card.ability.extra.lossden)
            local gain = SMODS.pseudorandom_probability(card, "suck_it_gain", 1, card.ability.extra.gainden)
            if gain then
                ease_dollars(card.ability.extra.gain)
                return
            elseif loss then
                ease_dollars(-card.ability.extra.loss)
            end
            SMODS.add_card({key = self.key})
        end
    end
}