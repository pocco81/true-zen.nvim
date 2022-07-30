local M = {}

local cnf = require("true-zen.config").options
local fn = vim.fn
local status

function M.on()
	if not fn.executable("kitty") then
		return
	end
	local cmd = "kitty @ --to %s set-font-size %s"
	fn.system(cmd:format(fn.expand("$KITTY_LISTEN_ON"), cnf.integrations.kitty.font))
	vim.cmd([[redraw]])
	status = true
end

function M.off()
	if status == true then
		local cmd = "kitty @ --to %s set-font-size %s"
		fn.system(cmd:format(fn.expand("$KITTY_LISTEN_ON"), "0"))
	end
	status = nil
end

return M
