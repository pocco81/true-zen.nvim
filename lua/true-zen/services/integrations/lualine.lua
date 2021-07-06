local api = vim.api
local cmd = vim.cmd

local M = {}

function M.enable_element()
	cmd([["set statusline=%!v:lua.require'lualine'.statusline()]])
end

function M.disable_element()
    cmd("set statusline=-")
end

return M
