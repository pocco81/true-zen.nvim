local M = {}


local cmd = vim.cmd



function M.enable_element()
	cmd("SignifyToggle")
end

function M.disable_element()
	cmd("SignifyToggle")
end



return M
