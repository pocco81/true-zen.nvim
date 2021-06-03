-- might be translated into vimL in the future for better syntax
vim.api.nvim_exec(
    [[
	augroup toggle_statusline
		autocmd!
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.top'.resume()" | endif
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.bottom'.resume()" | endif
		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.left'.resume()" | endif
	augroup END
]],
    false
)
