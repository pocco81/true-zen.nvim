

local opts = require("config").options
local cmd_settings = require("utils.cmd_settings")

-- left specific options
-- set number
-- set relativenumber
-- set signcolumn=no

function left_true()		-- show
	cmd_settings.map_settings(opts["left"], true)
end

function left_false()		-- don't show
	cmd_settings.map_settings(opts["left"], false)
end



return {
	left_true = left_true,
	left_false = left_false
}
