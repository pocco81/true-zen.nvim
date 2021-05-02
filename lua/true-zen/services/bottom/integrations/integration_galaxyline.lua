

local api = vim.api
local gl = require("galaxyline")



function enable_element()
	-- require('galaxyline').load_galaxyline()
	-- require("galaxyline")
	-- gl.galaxyline_augroup()
	gl.load_galaxyline()
end

function disable_element()
	-- api.nvim_command('augroup galaxyline')
	-- api.nvim_command('autocmd!')
	-- api.nvim_command('augroup END!')
	gl.disable_galaxyline()
	
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
