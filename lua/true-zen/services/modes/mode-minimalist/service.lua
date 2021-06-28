-- ui
local top = require("lua.true-zen.services.ui.top.init")
local bottom = require("lua.true-zen.services.ui.bottom.init")
local left = require("lua.true-zen.services.ui.left.init")

local M = {}

function M.on()
	top.main("off")
	bottom.main("off")
	left.main("off")
end

function M.off()
	top.main("on")
	bottom.main("on")
	left.main("on")
end

return M
