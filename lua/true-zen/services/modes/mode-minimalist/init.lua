local service = require("true-zen.services.modes.mode-minimalist.service")
local truezen = require("true-zen")

local M = {}
local status_mode_minimalist

function M.get_status()
    return status_mode_minimalist
end

function M.set_status(value)
    status_mode_minimalist = value
end

function M.on()
    if (truezen.before_mode_minimalist_on ~= nil) then
        truezen.before_mode_minimalist_on()
    end

    service.on()
    M.set_status("on")

    if (truezen.after_mode_minimalist_on ~= nil) then
        truezen.after_mode_minimalist_on()
    end
end

function M.off()
    if (truezen.before_mode_minimalist_off ~= nil) then
        truezen.before_mode_minimalist_off()
    end

    service.off()
    M.set_status("off")

    if (truezen.after_mode_minimalist_off ~= nil) then
        truezen.after_mode_minimalist_off()
    end
end

local function toggle()
    if (M.get_status() == "on") then
        M.off()
    else
        M.on()
    end
end

function M.main(option)
    option = option or 0

    if (option == "toggle") then
        toggle()
    elseif (option == "on") then
		if (M.get_status() == "off") then M.on() else print("TrueZen: cannot turn minimalist mode on because it is already on") end
    elseif (option == "off") then
		if (M.get_status() == "on") then M.off() else print("TrueZen: cannot turn minimalist mode off because it is already off") end
    end
end

return M
