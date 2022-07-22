local is_focused
local cmd = vim.cmd

local M = {}

function M.on()
	cmd("tab split")
	is_focused = true
end

function M.off()
	cmd("tabclose")
		is_focused = false
end

function M.toggle()
	if is_focused then
		M.off()
	else
		M.on()
	end
end

return M
