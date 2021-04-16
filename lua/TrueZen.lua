

-- local statusline = require("services.statusline")

local cmd = vim.cmd


--local function toggle_statusline()
--	-- check if status line is shown
--	--	if true, untoggle
--	--	if false, toggle

--end

local function statusline_true()		-- show
	-- turn status line on
	cmd("set laststatus=2 showtabline=2")
end

local function statusline_false()		-- don't show
	-- turn status line off
	cmd("set laststatus=0 showtabline=0")
end


-- local function main()
	
-- end

-- export the functions
return {
	-- toggle_statusline = toggle_statusline, -- called with TZStatusline
	statusline_true = statusline_true,
	statusline_false = statusline_false
}

