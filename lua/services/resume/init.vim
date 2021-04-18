


augroup toggle_statusline
	autocmd!
	" autocmd VimResume,FocusGained * lua require'lua.services.top'.resume()
	autocmd VimResume,FocusGained * lua require'lua.services.bottom'.resume()
augroup END
