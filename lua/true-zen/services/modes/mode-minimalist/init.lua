local service = require("true-zen.services.modes.mode-minimalist.service")

local opts = require("true-zen.config").options
local cmd = vim.cmd

local M = {}

local function get_status()
    return status_mode_minimalist
end

local function set_status(value)
    status_mode_minimalist = value
end

local function on()
	service.on()
    set_status("on")
end

local function off()
	service.off()
    set_status("off")
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
