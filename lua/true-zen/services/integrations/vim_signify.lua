local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd("SignifyToggle")
end

function M.disable_element()
	cmd("SignifyToggle")
end

return M
