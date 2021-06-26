local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")

local M = {}

function M.on()			-- show top line
	print("here 1")
	usp.load_settings("TOP", "OTHER")
end

function M.off()		-- hide top line
	print("here 2")
	usp.save_local_settings("TOP", opts["ui"]["top"])
	usp.load_settings(opts["ui"]["top"], "USER")
end


return M
