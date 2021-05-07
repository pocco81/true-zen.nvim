local M = {}

local bottom = require("true-zen.services.bottom.init")
local top = require("true-zen.services.top.init")
local left = require("true-zen.services.left.init")

-- bottom specific options

function M.minimalist_true()		-- show
	bottom.main(1)
	top.main(1)
	left.main(1)
end

function M.minimalist_false()		-- don't show
	bottom.main(2)
	top.main(2)
	left.main(2)
end



return M

