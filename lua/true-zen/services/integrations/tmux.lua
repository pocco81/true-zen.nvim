local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd("silent !tmux set status on")
end

function M.disable_element()
	cmd("silent !tmux set status off")
end

return M
