local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")
local cmd = vim.cmd

local M = {}

function M.on()
	usp.load_settings(opts['ui']['left'], 'OTHER')
end

function M.off()
	usp.load_settings(opts['ui']['left'], 'USER')
end

return M
