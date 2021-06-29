local M = {}
local bottom = {}
local top = {}
local left = {}

local cmd = vim.cmd

local function run_bool(element, value)
    if (value == true) then
        to_cmd = "setlocal " .. element
    else
        to_cmd = "setlocal no" .. element
    end
    cmd(to_cmd)
end

local function run_str_num(element, value)
    -- both have the same implementation
    to_cmd = "setlocal " .. element .. "=" .. value .. ""
    cmd(to_cmd)
end

local function assert_and_execute(element, value)
    if (type(value) == "boolean") then
        run_bool(element, value)
    elseif (type(value) == "number") then
        run_str_num(element, value)
    elseif (type(value) == "string") then
        run_str_num(element, value)
    end
end

local function get_table(tbl)
    if (tbl == "BOTTOM") then
        return bottom
    elseif (tbl == "TOP") then
        return top
    else
        return left
    end
end

function M.save_local_settings(tbl, element)
    local lcl_tbl = get_table(element)

    for key, value in pairs(tbl) do
        local current_state = vim.api.nvim_eval("&" .. key .. "")

        if (type(value) == "boolean") then
            if (current_state == 1) then
                lcl_tbl[key] = true
            else
                lcl_tbl[key] = false
            end
        elseif (type(value) == "number") then
            lcl_tbl[key] = tonumber(current_state)
        elseif (type(value) == "string") then
            lcl_tbl[key] = tostring(current_state)
        end
    end
end

function M.load_settings(tbl, tbl_group)
    if (tbl_group == "USER") then -- user settings
        for key, value in pairs(tbl) do
            assert_and_execute(key, value)
        end
    else -- saved settings
        if (next(get_table(tbl)) == nil) then
            print("TrueZen: Cannot toggle " .. tbl_group .. " on because it is already on")
        else
            for key, value in pairs(get_table(tbl)) do
                assert_and_execute(key, value)
            end
        end
    end
end

return M
