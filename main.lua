---@field mod Mod
---@field util table
---@field ui table
---@field content table
---@field leveling table
---@field load_order table
Valk = {
    mod = SMODS.current_mod,
    util = {},
    ui = {},
    content = {},
    leveling = {},
    load_order = { --defaults to 0 with metatable magic
        ["common.lua"] = 5,
        ["uncommon.lua"] = 10,
        ["rare.lua"] = 15,
        ["renowned.lua"] = 20,
        ["legendary.lua"] = 25,
        ["exquisite.lua"] = 30,
    },
}

Valk.mod.optional_features = {
    retrigger_joker = true,
}

Valk.mod.spectrallib_features = {
    "ascension_power",
}

setmetatable(Valk.load_order, {
    __index = function(t, k)
        return rawget(t, k) or 0 -- afformentioned metatable magic
    end,
})

local blacklist = {
    assets = true,
    lovely = true,
    [".github"] = true,
    [".git"] = true,
    ["localization"] = true,
}

local function load_file_native(path, id)
    if not path or path == "" then error("No path was provided to load.") end
    local file_content, readerr = SMODS.NFS.read(path)
    if not file_content then
        local error_message = "Error reading file '"
            .. path
            .. "' for mod with ID '"
            .. SMODS.current_mod.id
            .. "': "
            .. readerr
        return nil, error_message
    end
    local chunk, loaderr = load(file_content, "=[SMODS " .. SMODS.current_mod.id .. ' "' .. path .. '"]')
    if not chunk then
        local error_message = "Error processing file '"
            .. path
            .. "' for mod with ID '"
            .. SMODS.current_mod.id
            .. "': "
            .. loaderr
        return nil, error_message
    end
    return chunk
end
local function load_files(path, dirs_only, initial)
    local info = SMODS.NFS.getDirectoryItemsInfo(path)
    local to_load = {}
    if initial == nil then initial = true end
    for i, v in pairs(info) do
        if v.type == "directory" and not blacklist[v.name] then
            to_load = SMODS.merge_lists { to_load, load_files(path .. "/" .. v.name, false, false) }
            -- appends all files from the next directory deep to the list of things to load
        elseif not dirs_only then
            if string.find(v.name, ".lua") and not string.find(v.name, ".ignore_") then
                -- add to to_load by path
                table.insert(to_load, path .. "/" .. v.name)
            end
        end
    end

    if not initial then return to_load end

    local function sanitize(file)
        return file:match("([^/]+)$")
    end

    table.sort(to_load, function(a, b)
        return Valk.load_order[sanitize(a)] < Valk.load_order[sanitize(b)]
    end)

    for _, file in pairs(to_load) do
        local f, err = load_file_native(file)
        if f then
            print("Valk:Redux | Loading: " .. file)
            f()
            -- actually loads the file, as `load_file_native` and `load` return functions
        else
            error("error in file " .. file .. ": " .. err)
        end
    end
end
--[[
G.SPLASH_BACK:define_draw_steps({ -- meow?
        {
            shader = "splash",
            send = {
                { name = "time",       ref_table = G.TIMERS, ref_value = "REAL_SHADER" },
                { name = "vort_speed", ref_table = aquill,   ref_value = "bg_speed" },
                { name = "colour_1",   ref_table = G.C,      ref_value = "aqu_bg_prim" },
                { name = "colour_2",   ref_table = G.C,      ref_value = "aqu_bg_sec" },
            },
        },
})]]

---@param func_path string String that defines where to find the function. e.g. "Game.main_menu"
---@param func function Function to replace the given function with. Takes in the args of (original_function, ...) where ... is the args of the original function
function Valk.util.hook(func_path, func)
    local arr = {}
    for string in string.gmatch(func_path, "([^.]+)") do
        table.insert(arr, string)
    end
    local current_entry = _G
    local final_func = nil
    local continue = true
    for _, entry in pairs(arr) do
        local next_entry = current_entry[entry]
        if type(next_entry) == "function" then
            final_func = entry
            continue = false
        else
            current_entry = next_entry
        end
    end
    local original_function_object = current_entry[final_func]
    current_entry[final_func] = function(...)
        return func(original_function_object, ...)
    end
end

-- Same as `Valk.util.hook` but it does not allow for modifying return values, and simply runs code *before* the hooked function
function Valk.util.hook_before(func_path, func)
    Valk.util.hook(func_path, function(original, ...)
        func(original, ...)
        return original(...)
    end)
end

-- Same as `Valk.util.hook` but it does not allow for modifying return values, and simply runs code *after* the hooked function
function Valk.util.hook_after(func_path, func)
    Valk.util.hook(func_path, function(original, ...)
        local ret = original(...)
        func(original, ...)
        return ret
    end)
end

load_files(Valk.mod.path, true)
