local M = {}

local cnf = require("true-zen.config").options

function M.set_of(list)
	local set = {}
	for i = 1, #list do
		set[list[i]] = true
	end
	return set
end

function M.do_callback(mode, status, when)
	if type(cnf.modes[mode].callbacks[status .. "_" .. when]) == "function" then
		if vim.g["tz_disable_" .. mode .. "_" .. status .. "_" .. when] == true then
			vim.g["tz_disable_" .. mode .. "_" .. status .. "_" .. when] = false
		else
			cnf.modes[mode].callbacks[status .. "_" .. when]()
		end
	end
end

-- taken from: https://stackoverflow.com/questions/22831701/lua-read-beginning-of-a-string
function M.starts(str,start)
   return string.sub(str,1,string.len(start))==start
end

return M
