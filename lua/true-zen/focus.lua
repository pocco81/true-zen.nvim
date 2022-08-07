local M = {}

M.running = false
local cmd = vim.cmd
local data = require("true-zen.utils.data")
local echo = require("true-zen.utils.echo")

function M.on()
	data.do_callback("focus", "open", "pre")

	if vim.fn.winnr("$") == 1 then
		echo("there is only one window open", "error")
		return
	end
	cmd("tab split")
	M.running = true

	data.do_callback("focus", "open", "pos")
end

function M.off()
	data.do_callback("focus", "close", "pre")

	cmd("tabclose")
	M.running = false

	data.do_callback("focus", "close", "pos")
end

function M.toggle()
	if M.running then
		M.off()
	else
		M.on()
	end
end

return M
