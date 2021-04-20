

local api = vim.api



function enable_statusline()
	require('galaxyline').load_galaxyline()
end

function disable_statusline()
	api.nvim_command('augroup galaxyline')
	api.nvim_command('autocmd!')
	api.nvim_command('augroup END!')
end


return {
	enable_statusline = enable_statusline,
	disable_statusline = disable_statusline
}
