


vim.api.nvim_exec([[
	augroup toggle_statusline
		autocmd!
		autocmd VimResume,FocusGained * silent lua require'services.top'.resume()
		autocmd VimResume,FocusGained * silent lua require'services.bottom'.resume()
		autocmd VimResume,FocusGained * silent lua require'services.left'.resume()
	augroup END
]], false)

-- vim.api.nvim_exec([[
-- 	augroup toggle_statusline
-- 		autocmd!
-- 		autocmd VimResume,FocusGained * lua resume()
-- 	augroup END
-- ]], false)


