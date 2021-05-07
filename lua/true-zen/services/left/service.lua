local M = {}

local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- left specific options
-- set number
-- set relativenumber
-- set signcolumn=no

function M.left_true()		-- show
	cmd_settings.map_settings(opts["left"], true, "LEFT")
end

function M.left_false()		-- hide
	cmd_settings.map_settings(opts["left"], false, "LEFT")
end



return M
