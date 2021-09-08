local cmd = vim.cmd

local M = {}

function M.enable_element()
	require("galaxyline").load_galaxyline()
	require("galaxyline").galaxyline_augroup()
end

function M.disable_element()
	require("galaxyline").disable_galaxyline()
	require("galaxyline").inactive_galaxyline()
	cmd("setlocal statusline=-")
end

return M
