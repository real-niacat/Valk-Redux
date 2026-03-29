function Valk.util.localize_table_of_cards(cards)
    local names = {}
    for _, card in pairs(cards) do
        table.insert(names, localize { type = "name_text", set = card.config.center.set, key = card.config.center_key })
    end
    return names
end

function Valk.util.join_string_table(string_table)
    local str = ""
    for _, entry in pairs(string_table) do
        str = str .. entry
    end
    return str
end

function Valk.util.poll_set(set, seed)
    local pool = get_current_pool(set)
    local i = 1
    local element = pseudorandom_element(pool, seed .. i)
    while element == "UNAVAILABLE" do
        i = i + 1
        element = pseudorandom_element(pool, seed .. i)
    end
    return element
end

function Valk.util.poll_sets(sets, seed)
    local pool = {}
    for _, set in ipairs(sets) do
        pool = Valk.util.merge_arrays(pool, copy_table(get_current_pool(set)))
    end
    local i = 1
    local element = pseudorandom_element(pool, seed .. i)
    while element == "UNAVAILABLE" do
        i = i + 1
        element = pseudorandom_element(pool, seed .. i)
    end
    return element
end

function Valk.util.get_index(card)
    for i, i_card in ipairs(card.area.cards) do
        if i_card == card then
            return i
        end
    end
    error("Card not found in its own area. What the fuck are you doing?")
end

-- Merges two tables, giving the key-value pairs of both. Table B has higher priority if there are identical/overlapping keys
function Valk.util.merge_tables(a, b)
    local new = {}
    for key, value in pairs(a) do
        new[key] = value
    end
    for key, value in pairs(b) do
        new[key] = value
    end
    return new
end

function Valk.util.merge_arrays(a, b)
    local new = {}
    for i, value in ipairs(a) do
        table.insert(new, value)
    end
    for i, value in ipairs(b) do
        table.insert(new, value)
    end
    return new
end

function Valk.util.ui_safe(number)
    number = to_number(number)
    number = math.min(number, 1e100)
    number = math.max(number, -1e100)

    return number
end

function Valk.util.reload_localization()
    for i, v in pairs(SMODS.Mods) do
        if v.can_load and v.path then
            SMODS.handle_loc_file(v.path)
        end
    end
    return init_localization()
end

SMODS.Keybind {
    key = "reload_loc",
    key_pressed = "d",
    action = function(self)
        Valk.util.reload_localization()
    end,
}

SMODS.Keybind {
    key = "reveal_missing_credits",
    key_pressed = "l",
    action = function(self)
        local centers = {}
        for key, center in pairs(G.P_CENTERS) do
            if Valk.badges_keyed["creditless"].should_apply(center) then
                table.insert(centers, center)
            end
        end
        G.FUNCS.overlay_menu {
            definition = SMODS.card_collection_UIBox(centers, { 5, 5, 5 }, { back_func = "exit_overlay_menu" }),
        }
    end,
}

function Valk.util.poll_hand(seed, visible_only, exclude)
    local poker_hands = {}
    for handname, _ in pairs(G.GAME.hands) do
        if (visible_only and SMODS.is_poker_hand_visible(handname) or not visible_only) and handname ~= exclude then
            table.insert(poker_hands, handname)
        end
    end
    return pseudorandom_element(poker_hands, seed)
end

function Valk.util.mod_blind_size(func)
    local new = func(G.GAME.blind.chips)
    G.E_MANAGER:add_event(Event {
        trigger = "ease",
        ease = "insine", --easing type
        ref_table = G.GAME.blind,
        ref_value = "chips",
        ease_to = new, --end value
        delay = 2, --time taken
        func = function(t)
            return t
        end,
    })
end

Valk.util.hook_after("Card.add_to_deck", function(orig, self)
    if self.config.center.set == "Joker" then
        G.GAME.jokers_owned[self.config.center.key] = true
    end
end)

function Valk.util.unique_jokers()
    local c = 0
    for k, v in pairs(G.GAME.jokers_owned) do
        c = c + 1
    end
    return c
end

function Valk.util.get_matching(tab, func)
    local r = {}
    for k, v in pairs(tab) do
        if func(v) then
            table.insert(r, v)
        end
    end
    return r
end

function Valk.util.get_description_ui(desc, args, conf)
    conf = conf or { align = "cm" }
    args = args or {}
    local result = {}
    for _, line in ipairs(desc) do
        local ui_line = SMODS.localize_box(loc_parse_string(line), args)
        table.insert(result, {
            n = G.UIT.R,
            config = { align = args.align or "cm" },
            nodes = ui_line,
        })
    end
    return {
        n = G.UIT.C,
        config = conf,
        nodes = result,
    }
end

-- Mostly an analog to update_hand_text, but has some extra customizability
function Valk.util.hand_text(config, vals)
    config = config or {}
    G.E_MANAGER:add_event(Event {
        trigger = config.trigger or "before",
        blockable = not config.immediate,
        delay = config.delay or 0.8,
        func = function()
            local col = G.C.GREEN
            for name, parameter in pairs(SMODS.Scoring_Parameters) do
                if vals[name] then
                    -- DIFFERENCE: base update_hand_text uses delta as the difference, this function doesn't do that
                    -- give it the value you *want* to show up on screen
                    local delta = is_number(vals[name]) and vals[name] or 0

                    if delta < 0 then
                        delta = number_format(delta)
                        col = G.C.RED
                    elseif delta > 0 then
                        delta = "+" .. number_format(delta)
                    else
                        delta = number_format(delta)
                    end

                    if type(vals[name]) == "string" then
                        delta = vals[name]
                    end
                    if not vals.StatusText then
                        G.GAME.current_round.current_hand[name] = vals[name]
                    end
                    local uie = G.hand_text_area[name] or G.HUD:get_UIE_by_ID("hand_" .. name)
                    if uie then
                        uie:update(0)
                        if vals.StatusText then
                            local StatusText = {
                                text = delta,
                                scale = config.scale or 0.8,
                                hold = config.hold or 1,
                                cover = uie.parent,
                                cover_colour = vals[name .. "_colour"] or vals.colour or G.C.WHITE, -- give it the colour, i'm not here to do the work for you
                                emboss = 0.05,
                                align = "cm",
                                cover_align = uie.parent.config.align,
                            }
                            if type(vals.StatusText) == "string" then
                                StatusText.text = vals.StatusText
                            elseif type(vals.StatusText) == "table" then
                                for k, v in pairs(vals.StatusText) do
                                    if v ~= nil then
                                        StatusText[k] = v
                                    end
                                end
                            end

                            attention_text(StatusText)
                        end

                        if (vals[name .. "_juice"] or parameter.juice_on_update) and not G.TAROT_INTERRUPT then
                            G.hand_text_area[name]:juice_up()
                        end
                    end
                end
            end

            if vals.handname then
                G.GAME.current_round.current_hand.handname = vals.handname
                if not config.nopulse then
                    G.hand_text_area.handname.config.object:pulse(0.2)
                end
            end
            if vals.chip_total then
                G.GAME.current_round.current_hand.chip_total = vals.chip_total
                G.hand_text_area.chip_total.config.object:pulse(0.5)
            end
            if vals.level and G.GAME.current_round.current_hand.hand_level ~= " " .. localize("k_lvl") .. tostring(vals.level) then
                if vals.level == "" then
                    G.GAME.current_round.current_hand.hand_level = vals.level
                else
                    G.GAME.current_round.current_hand.hand_level = " " .. localize("k_lvl") .. tostring(vals.level)
                    if is_number(vals.level) then
                        G.hand_text_area.hand_level.config.colour = G.C.HAND_LEVELS[math.floor(to_number(math.min(7, vals.level)))]
                    else
                        G.hand_text_area.hand_level.config.colour = G.C.HAND_LEVELS[1]
                    end
                    G.hand_text_area.hand_level:juice_up()
                end
            end
            if config.sound and not config.modded then
                play_sound(config.sound, config.pitch or 1, config.volume or 1)
            end
            if config.modded then
                SMODS.juice_up_blind()
                G.E_MANAGER:add_event(Event {
                    trigger = "after",
                    delay = 0.06 * G.SETTINGS.GAMESPEED,
                    blockable = false,
                    blocking = false,
                    func = function()
                        play_sound("tarot2", 0.76, 0.4)
                        return true
                    end,
                })
                play_sound("tarot2", 1, 0.4)
            end
            return true
        end,
    })
end

-- taken from feli's jokeria
function Valk.util.weighted_pool(pool, seed)
    if type(pool) == "table" then
        local roll = nil
        roll = roll or pseudorandom(seed)
        local total = 0

        for _, v in ipairs(pool) do
            local w = v.weight or v[2] or 1
            total = total + w
        end

        local target = roll * total
        local sum = 0

        for _, v in ipairs(pool) do
            local w = v.weight or v[2] or 1
            sum = sum + w
            if target <= sum then
                return v.key or v[1]
            end
        end
    elseif pool then
        error("pool is not a table ({key, weight}")
    else
        error("pool is nil")
    end
end

function Valk.util.poll_kitty(seed)
    local available = {}
    local rarity_ref = setmetatable({
        "Common",
        "Uncommon",
        "Rare",
        "Legendary",
    }, {
        __index = function(t, k)
            return rawget(t, k) or k
        end,
    })
    for _, cen in pairs(G.P_CENTER_POOLS.Kitty) do
        local rarity = SMODS.Rarities[rarity_ref[cen.rarity]]
        local weight = rarity.get_weight and rarity:get_weight(rarity.default_weight) or rarity.default_weight
        table.insert(available, { cen.key, weight })
    end
    return Valk.util.weighted_pool(available, seed)
end

function Valk.util.split_by_period(str, allow_numbers)
    local arr = {}
    for string in string.gmatch(str, "([^.]+)") do
        table.insert(arr, allow_numbers and tonumber(string) or string)
    end
    return arr
end

function Valk.util.save_to_profile(path, value)
    local arr = Valk.util.split_by_period(path, true)
    local profile = G.PROFILES[G.SETTINGS.profile]
    local current = profile
    for i, key in ipairs(arr) do
        if i == #arr then
            current[key] = value
        else
            if current[key] then
                assert(type(current[key]) == "table", "Attempt to save profile value to a non-table path '" .. key .. "'")
            end
            current[key] = current[key] or {}
            current = current[key]
        end
    end
end

function Valk.util.get_from_profile(path)
    local arr = Valk.util.split_by_period(path, true)
    local profile = G.PROFILES[G.SETTINGS.profile]
    local current = profile
    for i, key in ipairs(arr) do
        if i ~= #arr then
            current = current[key]
        end
    end
    return current
end
