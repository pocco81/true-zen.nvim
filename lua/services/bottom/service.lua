


local opts = require("config").options
local cmd_settings = require("utils.cmd_settings")
local integration_galaxyline = require("services.mode-ataraxis.integrations.integration_galaxyline")

-- local cmd = vim.cmd

-- bottom specific options
-- set noshowmode
-- set noruler
-- set laststatus=0
-- set noshowcmd
-- set cmdheight=1

function bottom_true()		-- show
	cmd_settings.map_settings(opts["bottom"], true)
	integration_galaxyline.enable_statusline()
end

function bottom_false()		-- don't show
	cmd_settings.map_settings(opts["bottom"], false)
	integration_galaxyline.disable_statusline()
end



return {
	bottom_true = bottom_true,
	bottom_false = bottom_false
}

