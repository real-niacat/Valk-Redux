function Valk.leveling.current_gate()
    return G.GAME.valk_leveling.gate_intensity
end

function Valk.leveling.set_blinds() end

-- all effects are temporary and go away if you lower your gate intensity
Valk.leveling.threshes = {
    ExtraScaling = 1,
    --BigBoss = 3, -- waiting for Ice's PR
    ExpensiveCards = 5,
    --SmallBoss = 7,
    HalfDiscards = 10, -- /2 discards when blind selected
    UnsellableJokers = 15,
    Skimming = 17, -- lose $1 at end of round per joker owned
}

function Valk.leveling.generate_gate_text()
    local t = {}
    for key, v in pairs(Valk.leveling.get_active_gates()) do
        if v then
            table.insert(t, localize("ph_gate_" .. key))
        end
    end
    if #t == 0 then
        table.insert(t, localize("ph_no_gates"))
    end
    return {
        title = localize("ph_active_gates"),
        text = t,
    }
end

function Valk.leveling.get_active_gates()
    local cur = Valk.leveling.current_gate()
    local t = {}
    for k, v in pairs(Valk.leveling.threshes) do
        if cur >= v then
            t[k] = true
        end
    end
    return t
end

Valk.util.hook("get_blind_amount", function(original, ante)
    local base = original(ante)
    if Valk.leveling.get_active_gates().ExtraScaling then
        base = base * 1 + (ante / G.GAME.win_ante)
    end
    return base
end)

Valk.util.hook_after("Card.set_cost", function(orig, card)
    if Valk.leveling.get_active_gates().ExpensiveCards then
        card.cost = card.cost + 2
    end
end)

Valk.util.hook("Card.can_sell_card", function(original, self, context)
    if self.config.center and self.config.center.set == "Joker" and Valk.leveling.get_active_gates().UnsellableJokers then
        return false
    end
    return original(self, context)
end)
