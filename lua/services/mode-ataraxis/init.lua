
local service = require("services.mode-minimalist.service")

local cmd = vim.cmd
local api = vim.api

-- show and hide ataraxis funcs
local function ataraxis_true()
	ataraxis_show = 1
	service.ataraxis_true()
end

local function ataraxis_false()
	ataraxis_show = 0
	service.minimalist_false()
end

-- 1 if being shown
-- 0 if being hidden
local function toggle()
	if (minimalist_show == 1) then				-- minimalist true, shown; thus, hide
		minimalist_false()
	elseif (minimalist_show == 0) then			-- minimalist false, hidden; thus, show
		minimalist_true()
	elseif (minimalist_show == nil) then
		if ((left.left_show == nil) and (bottom.bottom_show == nil) and (top.top_show == nil)) then
			minimalist_show = 0
			minimalist_false()
		elseif ((left.left_show == 1) and (bottom.bottom_show == 1) and (top.top_show == 1)) then
			minimalist_show = 1
			minimalist_false()
		elseif ((left.left_show == 0) and (bottom.bottom_show == 0) and (top.top_show == 0)) then
			minimalist_show = 0
			minimalist_true()

		elseif((api.nvim_eval("&laststatus > 0 || &showtabline > 0") == 1) and (api.nvim_eval("&showtabline > 0") == 1) and (api.nvim_eval("&number > 0 || &relativenumber > 0") == 1)) then
			minimalist_show = 1
			minimalist_false()

		elseif((api.nvim_eval("&laststatus > 0 || &showtabline > 0") == 0) and (api.nvim_eval("&showtabline > 0") == 0) and (api.nvim_eval("&number > 0 || &relativenumber > 0") == 0)) then
			-- cmd("echo 'SEVEN'")
			minimalist_show = 0
			minimalist_true()
		else
			-- cmd("echo 'EIGHT'")
			minimalist_show = 1
			minimalist_false()
		end
	else
		-- cmd("echo 'NINE'")
		minimalist_show = 1
		minimalist_false()
	end
end


function main(option)

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


return {
	main = main
}
