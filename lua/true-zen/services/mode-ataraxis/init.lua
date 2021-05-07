local M = {}

local service = require("true-zen.services.mode-ataraxis.service")

local cmd = vim.cmd
local api = vim.api

-- show and hide ataraxis funcs
local function ataraxis_true()
	M.ataraxis_show = 1
	service.ataraxis_true()
end

local function ataraxis_false()
	M.ataraxis_show = 0
	service.ataraxis_false()
end

-- 1 if being shown
-- 0 if being hidden
local function toggle()
	if (M.ataraxis_show == 1) then				-- ataraxis true, shown; thus, hide
		ataraxis_false()
	elseif (M.ataraxis_show == 0) then			-- ataraxis false, hidden; thus, show
		ataraxis_true()
	elseif (M.ataraxis_show == nil) then
		M.ataraxis_show = 1
		ataraxis_false()
	else
		M.ataraxis_show = 1
		ataraxis_false()
	end
end


function M.main(option)

	option = option or 0

	if (option == 0) then			-- toggle statuline (on/off)
		toggle()
	elseif (option == 1) then		-- show status line
		ataraxis_true()
	elseif (option == 2) then
		ataraxis_false()
	else
		-- not recognized
	end
end


return M
