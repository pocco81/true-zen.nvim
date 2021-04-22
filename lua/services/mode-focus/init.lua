

local service = require("services.mode-focus.service")

local cmd = vim.cmd
local api = vim.api


-- show and hide focus funcs
local function focus_true()		-- focus window

	focus_show = 1
	service.focus_true()

end

local function focus_false()		-- unfocus window

	focus_show = 0
	service.focus_false()

end

-- 1 if being shown
-- 0 if being hidden
local function toggle()
end


function main(option)

	option = option or 0

	if (option == 0) then			-- toggle focus (on/off)
		toggle()
	elseif (option == 1) then		-- focus window
		focus_true()
	elseif (option == 2) then		-- unfocus window
		focus_false()
	else
		-- not recognized
	end
end


return {
	main = main
}
