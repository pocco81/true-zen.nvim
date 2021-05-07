local M = {}



local cmd = vim.cmd



function M.enable_element()
	cmd("Limelight")
end

function M.disable_element()
	cmd("Limelight!")
end



return M
