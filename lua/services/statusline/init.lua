
-- imports
-- TrueZen
local service = require("lua.services.statusline.modules.service")
-- local test_file = require("test_file")

-- vars
Is_statusline_shown = true


--local function toggle_statusline()
--	-- check if status line is shown
--	--	if true, untoggle
--	--	if false, toggle

--end

local function toggle()

	if (Is_statusline_shown == true) then
		-- service.statusline_false()
		cmd("set laststatus=2 showtabline=2")
		Is_statusline_shown = false
	elseif (Is_statusline_shown == false) then
		-- service.statusline_true()
		cmd("set laststatus=0 showtabline=0")
		Is_statusline_shown = true
	else
		-- nothing
	end
end

local function statusline_true()
	-- service.statusline_true()
end

local function statusline_false()
	-- service.statusline_false()
end

local cmd = vim.cmd

function main(option)
	
	option = option or 0

	if (option == 0) then			-- toggle statuline (on/off)
		toggle()
	elseif (option == 1) then		-- show status line
		-- statusline_true()
		cmd("set laststatus=2 showtabline=2")
	elseif (option == 2) then
		-- statusline_false()
		cmd("set laststatus=0 showtabline=0")
	else
		-- not recognized
	end
end


return {
	main = main
}



