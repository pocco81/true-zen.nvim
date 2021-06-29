local api = vim.api
local cmd = vim.cmd

local M = {}

function M.enable_element(element)
	if (element == "cusorline") then require("no-clc.modules.cusorline.init").main(true)
	elseif (element == "cusorcolumn") then require("no-clc.modules.cusorcolumn.init").main(true) end
end

function M.disable_element(element)
	if (element == "cusorline") then require("no-clc.modules.cusorline.init").main(false)
	elseif (element == "cusorcolumn") then require("no-clc.modules.cusorcolumn.init").main(false) end
end

return M
