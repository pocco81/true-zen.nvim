

local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- top specific options
-- set showtabline=<num>

function top_true(is_toggled)		-- show
	cmd_settings.map_settings(opts["top"], true, "TOP", is_toggled)
end

function top_false(is_toggled)		-- don't show
	cmd_settings.map_settings(opts["top"], false, "TOP", is_toggled)
end



return {
	top_true = top_true,
	top_false = top_false
}

