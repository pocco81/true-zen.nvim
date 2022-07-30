local M = {}

local cnf = require("true-zen.config").options

function M.set_of(list)
	local set = {}
	for i = 1, #list do
		set[list[i]] = true
	end
	return set
end

function M.do_callback(mode, status)
	if type(cnf.modes[mode][status .. "_callback"]) == "function" then
		cnf.modes[mode][status .. "_callback"]()
	end
end

return M
