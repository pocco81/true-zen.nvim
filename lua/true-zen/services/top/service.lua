local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")

local M = {}

function M.on() -- show top line
    usp.load_settings("TOP", "OTHER")
end

function M.off() -- hide top line
    -- usp.save_local_settings(opts["ui"]["top"], "TOP")
    usp.load_settings(opts["ui"]["top"], "USER")
end

return M
