


local opts = require("config").options
local cmd_settings = require("utils.cmd_settings")

-- local cmd = vim.cmd

-- bottom specific options
-- set noshowmode
-- set noruler
-- set laststatus=0
-- set noshowcmd
-- set cmdheight=1

function bottom_true()		-- show
	cmd_settings.map_settings(opts["bottom"], true)
end

function bottom_false()		-- don't show
	cmd_settings.map_settings(opts["bottom"], false)
end



return {
	bottom_true = bottom_true,
	bottom_false = bottom_false
}

