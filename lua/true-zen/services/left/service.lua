local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")
local cmd = vim.cmd

local M = {}

function M.on()
    usp.load_settings("LEFT", "OTHER")
end

function M.off()
    usp.save_local_settings(opts["ui"]["left"], "LEFT")
    -- usp.load_settings(opts["ui"]["left"], "USER")
    cmd([[call g:TrueZenBufDo("lua require'true-zen.utils.ui_settings_applier'.load_settings(require'true-zen.config'.options['ui']['left'], 'USER')")]])
end

return M
