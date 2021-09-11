local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd("Gitsigns attach")
end

function M.disable_element()
	cmd("Gitsigns detach_all")
end

return M
