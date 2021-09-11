local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd("Limelight")
end

function M.disable_element()
	cmd("Limelight!")
end

return M
