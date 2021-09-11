local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd([[call lightline#enable()]])
end

function M.disable_element()
	cmd([[call lightline#disable()]])
end

return M
