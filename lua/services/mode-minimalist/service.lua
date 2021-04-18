


local bottom = require("services.bottom.init")
local top = require("services.top.init")
local left = require("services.left.init")

-- bottom specific options

function minimalist_true()		-- show
	bottom.main(1)
	top.main(1)
	left.main(1)
end

function minimalist_false()		-- don't show
	bottom.main(2)
	top.main(2)
	left.main(2)
end



return {
	minimalist_true = minimalist_true,
	minimalist_false = minimalist_false
}

