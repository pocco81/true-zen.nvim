
-- imports
-- TrueZen
-- local service = require("service123")

-- API



-- vars
Is_statusline_shown = true


--local function toggle_statusline()
--	-- check if status line is shown
--	--	if true, untoggle
--	--	if false, toggle

--end

local cmd = vim.cmd

function statusline_true()		-- show
	-- turn status line on
	cmd("set laststatus=2 showtabline=2")
end

function statusline_false()		-- don't show
	-- turn status line off
	cmd("set laststatus=0 showtabline=0")
end




local function toggle()

	if (Is_statusline_shown == true) then
		-- service.statusline_false()
		statusline_true()
		Is_statusline_shown = false
	elseif (Is_statusline_shown == false) then
		-- service.statusline_true()
		statusline_false()
		Is_statusline_shown = true
	else
		-- nothing
	end
end

-- local function statusline_true()
-- 	service.statusline_true()
-- end

-- local function statusline_false()
-- 	service.statusline_false()
-- end


function main(option)
	
	option = option or 0

	if (option == 0) then			-- toggle statuline (on/off)
		-- toggle()
		cmd("echo 'hello'")
	elseif (option == 1) then		-- show status line
		-- statusline_true()
		cmd("echo 'hello'")
	elseif (option == 2) then
		-- statusline_false()
		cmd("echo 'hello'")
	else
		-- not recognized
	end
end


return {
	main = main
}



