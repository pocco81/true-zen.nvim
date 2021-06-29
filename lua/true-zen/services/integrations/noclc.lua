local api = vim.api
local cmd = vim.cmd

local M = {}

function M.enable_element(element)
	if (element == "cursorline") then require("no-clc.modules.cursorline.init").main(true)
	elseif (element == "cursorcolumn") then require("no-clc.modules.cursorcolumn.init").main(true) end
end

function M.disable_element(element)
	if (element == "cursorline") then require("no-clc.modules.cursorline.init").main(false)
	elseif (element == "cursorcolumn") then require("no-clc.modules.cursorcolumn.init").main(false) end
end

return M
