


local opts = require("true-zen.config").options
local cmd_settings = require("true-zen.utils.cmd_settings")

-- local cmd = vim.cmd

-- bottom specific options
-- set noshowmode
-- set noruler
-- set laststatus=0
-- set noshowcmd
-- set cmdheight=1

function bottom_true(is_toggled)		-- show
	cmd_settings.map_settings(opts["bottom"], true, "BOTTOM", is_toggled)
end

function bottom_false(is_toggled)		-- don't show
	cmd_settings.map_settings(opts["bottom"], false, "BOTTOM", is_toggled)
end



return {
	bottom_true = bottom_true,
	bottom_false = bottom_false
}

