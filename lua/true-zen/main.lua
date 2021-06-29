local M = {}

local bottom = require("true-zen.services.ui.bottom.init")
local top = require("true-zen.services.ui.top.init")
local left = require("true-zen.services.ui.left.init")

-- better to run it when it's going to be used and not at startup
require("true-zen.utils.viml_funcs")

local minimalist_mode = require("true-zen.services.modes.mode-minimalist.init")
local ataraxis_mode = require("true-zen.services.modes.mode-ataraxis.init")
local focus_mode = require("true-zen.services.modes.mode-focus.init")

local cmd = vim.cmd

function M.main(option, command_option)
    option = option or 0
    command_option = command_option or 0

    if (option == 0) then
        bottom.main(command_option)
    elseif (option == 1) then
        top.main(command_option)
    elseif (option == 2) then
        left.main(command_option)
    elseif (option == 3) then
        minimalist_mode.main(command_option)
    elseif (option == 4) then
        ataraxis_mode.main(command_option)
    elseif (option == 5) then
        focus_mode.main(command_option)
    end
end

return M
