


vim.api.nvim_exec([[
	augroup toggle_statusline
		autocmd!
		" autocmd VimResume,FocusGained * lua require'lua.services.top'.resume()
		autocmd VimResume,FocusGained * lua require'lua.services.bottom'.resume()
	augroup END
]], false)

-- vim.api.nvim_exec([[
-- 	augroup toggle_statusline
-- 		autocmd!
-- 		autocmd VimResume,FocusGained * lua resume()
-- 	augroup END
-- ]], false)


