local M = {}

local is_focused
local cmd = vim.cmd
local data = require("true-zen.utils.data")
local echo = require("true-zen.utils.echo")

function M.on()
	if vim.fn.winnr('$') == 1 then
		echo("there is only one window open", "error")
		return
	end
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
