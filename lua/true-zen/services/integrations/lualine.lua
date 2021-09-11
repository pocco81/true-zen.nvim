local cmd = vim.cmd

local M = {}

function M.enable_element()
	vim.g.ran = true
	-- cmd([[set statusline=%!v:lua.require'lualine'.statusline()]])
	vim.o.statusline = "%!v:lua.require'lualine'.statusline()"
	-- stylua: ignore
	vim.api.nvim_exec([[
		augroup lualine
		autocmd!
		autocmd WinLeave,BufLeave * lua vim.wo.statusline=require'lualine'.statusline()
		autocmd BufWinEnter,WinEnter,BufEnter * set statusline<
		autocmd VimResized * redrawstatus
		augroup END
	]], false)
end

function M.disable_element()
	cmd("set statusline=-")
	cmd("aug lualine | au! | aug END")
end

return M
