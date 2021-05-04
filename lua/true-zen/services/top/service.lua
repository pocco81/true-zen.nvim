

local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- top specific options
-- set showtabline=<num>

function top_true()		-- show
	vim.cmd("echo 'I RAN TRUE'")
	cmd_settings.map_settings(opts["top"], true, "TOP")
end

function top_false()		-- don't show
	vim.cmd("echo 'I RAN FALSE'")
	cmd_settings.map_settings(opts["top"], false, "TOP")
end



return {
	top_true = top_true,
	top_false = top_false
}

