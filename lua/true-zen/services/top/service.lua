local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")

local M = {}

function M.on()
	print("here 1")
	usp.save_local_settings("TOP")
	usp.load_settings(opts["ui"]["top"], "USER")
end

function M.off()
	print("here 2")
	usp.load_settings("TOP", "OTHER")
end


return M
