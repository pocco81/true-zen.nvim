local cmd = vim.cmd
local api = vim.api

local M = {}

function M.enable_element()
	vim.o.statusline = '%!v:lua.require\'feline\'.statusline()'
	-- stylua: ignore
	api.nvim_exec([[
		aug feline
			au!
			au WinEnter,BufEnter * set statusline<
			au WinLeave,BufLeave * lua vim.wo.statusline=require'feline'.statusline()
			au ColorScheme * lua require'feline'.reset_highlights()
		aug END
	]], false)
end

function M.disable_element()
	cmd([[aug feline | au! | aug END]])
	cmd("set statusline=-")
end

return M
