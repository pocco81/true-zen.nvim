local service = require("true-zen.services.modes.mode-ataraxis.service")
-- local truezen = require("true-zen.init")

local M = {}

local function get_status()
    return status_mode_ataraxis
end

local function set_status(value)
    status_mode_ataraxis = value
end

local function on()
    service.on()
    set_status("on")
end

local function off()
    service.off()
    set_status("off")
end

function M.resume()

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
