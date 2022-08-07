local M = {}

local status
local present, lualine = pcall(require, "lualine")
if not present then
	return
end

function M.on()
	lualine.hide()
	vim.o.statusline = " "
	status = true
end

function M.off()
	if status == true then
		lualine.hide { unhide = true }
	end
	status = nil
end

return M
