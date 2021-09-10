local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd("TwilightEnable")
end

function M.disable_element()
	cmd("TwilightDisable")
end

return M
