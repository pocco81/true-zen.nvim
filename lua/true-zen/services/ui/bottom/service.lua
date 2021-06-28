local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")

local M = {}

function M.on()
    usp.load_settings("BOTTOM", "OTHER")
end

function M.off()
    usp.load_settings(opts["ui"]["bottom"], "USER")
end

return M
