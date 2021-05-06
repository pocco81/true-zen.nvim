

local api = vim.api
local cmd = vim.cmd
-- local gl = require("galaxyline")



function enable_element()
	require('galaxyline').load_galaxyline()
	require('galaxyline').galaxyline_augroup()
end

function disable_element()
	require("galaxyline").disable_galaxyline()
	require("galaxyline").inactive_galaxyline()
	cmd("setlocal statusline=-")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
