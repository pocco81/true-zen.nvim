

local service = require("services.mode-minimalist.service")
local opts = require("config").options
local bottom = require("services.bottom.init")
local top = require("services.top.init")
local left = require("services.left.init")
local tz_main = require("tz_main")

local cmd = vim.cmd
local api = vim.api

-- show and hide minimalist funcs
local function minimalist_true()		-- show everything
	if (opts["before_minimalist_mode_shown"] == true) then
		tz_main.before_minimalist_mode_shown()
	else
		-- nothing
	end

	minimalist_show = 1
	service.minimalist_true()

	if (opts["after_minimalist_mode_shown"] == true) then
		tz_main.after_minimalist_mode_shown()
	else
		-- nothing
	end
end

local function minimalist_false()		-- hide everything
	if (opts["before_minimalist_mode_hidden"] == true) then
		tz_main.before_minimalist_mode_hidden()
	else
		-- nothing
	end

	minimalist_show = 0
	service.minimalist_false()

	if (opts["after_minimalist_mode_hidden"] == true) then
		tz_main.after_minimalist_mode_hidden()
	else
		-- nothing
	end
end

-- 1 if being shown
-- 0 if being hidden
local function toggle()
	-- minimalist_show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
	if (minimalist_show == 1) then				-- minimalist true, shown; thus, hide
		-- cmd("echo 'ONE'")
		minimalist_false()
	elseif (minimalist_show == 0) then			-- minimalist false, hidden; thus, show
		-- cmd("echo 'TWO'")
		minimalist_true()
	elseif (minimalist_show == nil) then
		-- guess by context
		if ((left.left_show == nil) and (bottom.bottom_show == nil) and (top.top_show == nil)) then
			-- cmd("echo 'THREE'")
			minimalist_show = 0
			minimalist_false()
		elseif ((left.left_show == 1) and (bottom.bottom_show == 1) and (top.top_show == 1)) then
			-- cmd("echo 'FOUR'")
			minimalist_show = 1
			minimalist_false()
		elseif ((left.left_show == 0) and (bottom.bottom_show == 0) and (top.top_show == 0)) then
			-- cmd("echo 'FIVE'")
			minimalist_show = 0
			minimalist_true()

		elseif((api.nvim_eval("&laststatus > 0 || &showtabline > 0") == 1) and (api.nvim_eval("&showtabline > 0") == 1) and (api.nvim_eval("&number > 0 || &relativenumber > 0") == 1)) then
			-- cmd("echo 'SIX'")
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
		minimalist_true()
	elseif (option == 2) then
		minimalist_false()
	else
		-- not recognized
	end
end


return {
	main = main
}
