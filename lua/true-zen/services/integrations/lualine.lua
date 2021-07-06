local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd([["setlocal statusline=%!v:lua.require'lualine'.statusline()]])
end

function M.disable_element()
    cmd("setlocal statusline=-")
end

return M
