local M = {}

local is_focused
local cmd = vim.cmd
local data = require("true-zen.utils.data")
local echo = require("true-zen.utils.echo")

function M.on()
	if vim.fn.winnr("$") == 1 then
		echo("there is only one window open", "error")
		return
	end
	cmd("tab split")
	is_focused = true
	data.do_callback("focus", "open")
end

function M.off()
	cmd("tabclose")
	is_focused = false
	data.do_callback("focus", "close")
end

function M.toggle()
	if is_focused then
		M.off()
	else
		M.on()
	end
end

return M
