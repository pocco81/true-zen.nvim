local M = {}

local is_focused
local cmd = vim.cmd
local data = require("true-zen.utils.data")

function M.on()
	data.do_callback("focus", "open")
	cmd("tab split")
	is_focused = true
end

function M.off()
	data.do_callback("focus", "close")
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
