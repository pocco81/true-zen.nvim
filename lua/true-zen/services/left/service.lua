

local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- left specific options
-- set number
-- set relativenumber
-- set signcolumn=no

function left_true(is_toggled)		-- show
	cmd_settings.map_settings(opts["left"], true, "LEFT", is_toggled)
end

function left_false(is_toggled)		-- hide
	cmd_settings.map_settings(opts["left"], false, "LEFT", is_toggled)
end



return {
	left_true = left_true,
	left_false = left_false
}
