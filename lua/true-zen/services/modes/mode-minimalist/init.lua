local service = require("true-zen.services.modes.mode-minimalist.service")
local truezen = require("true-zen")

local M = {}

local function get_status()
    return status_mode_minimalist
end

local function set_status(value)
    status_mode_minimalist = value
end

local function on()
    if (truezen.before_mode_minimalist_on ~= nil) then
        truezen.before_mode_minimalist_on()
    end

    service.on()
    set_status("on")

    if (truezen.after_mode_minimalist_on ~= nil) then
        truezen.after_mode_minimalist_on()
    end
end

local function off()
    if (truezen.before_mode_minimalist_off ~= nil) then
        truezen.before_mode_minimalist_off()
    end

    service.off()
    set_status("off")

    if (truezen.after_mode_minimalist_off ~= nil) then
        truezen.after_mode_minimalist_off()
    end
end

local function toggle()
    if (get_status() == "on") then
        off()
    else
        on()
    end
end

function M.main(option)
    option = option or 0

    if (option == "toggle") then
        toggle()
    elseif (option == "on") then
        on()
    elseif (option == "off") then
        off()
    end
end

return M
