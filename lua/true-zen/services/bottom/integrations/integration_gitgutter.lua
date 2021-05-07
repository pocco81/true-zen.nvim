local M = {}


local cmd = vim.cmd



function M.enable_element()
	cmd("silent! GitGutterEnable")
end

function M.disable_element()
	cmd("silent! GitGutterDisable")
end



return M
