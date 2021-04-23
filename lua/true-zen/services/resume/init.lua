


vim.api.nvim_exec([[
	augroup toggle_statusline
		autocmd!
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.top'.resume()
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.bottom'.resume()
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.left'.resume()
	augroup END
]], false)



