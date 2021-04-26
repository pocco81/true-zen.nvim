



local function resume_all()

	-- if has("patch-7.4.710") | set listchars+=space:· | else | set listchars+=trail:· | endif

	vim.api.nvim_exec([[
		augroup toggle_statusline
			autocmd!
			autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.top'.resume()" | endif
			autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.bottom'.resume()" | endif
			autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.left'.resume()" | endif
		augroup END
	]], false)

	-- vim.api.nvim_exec([[
	-- 	augroup toggle_statusline
	-- 		autocmd!
	-- 		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.top'.resume()
	-- 		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.bottom'.resume()
	-- 		autocmd VimResume,FocusGained,WinEnter,BufWinEnter * lua require'true-zen.services.left'.resume()
	-- 	augroup END
	-- ]], false)
end

if (vim.api.nvim_eval("&modifiable") == 1) then
	resume_all()
else
	-- nothing
end



