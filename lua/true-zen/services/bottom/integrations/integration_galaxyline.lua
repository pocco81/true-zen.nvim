

local api = vim.api



function enable_element()
	require('galaxyline').load_galaxyline()
end

function disable_element()
	api.nvim_command('augroup galaxyline')
	api.nvim_command('autocmd!')
	api.nvim_command('augroup END!')
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
