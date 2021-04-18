

local service = require("services.mode-minimalist.service")

local bottom = require("services.bottom.init")
local top = require("services.top.init")
local left = require("services.left.init")

local cmd = vim.cmd
local api = vim.api

-- show and hide minimalist funcs
local function minimalist_true()
	minimalist_show = 1
	service.minimalist_true()
end

local function minimalist_false()
	minimalist_show = 0
	service.minimalist_false()
end

local function toggle()
	-- minimalist_show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
	if (minimalist_show == 1) then				-- minimalist true, shown; thus, hide
		minimalist_false()
	elseif (minimalist_show == 0) then			-- minimalist false, hidden; thus, show
		minimalist_true()
	elseif (minimalist_show == nil) then
		-- guess by context
		if ((left.left_show == nil) and (bottom.bottom_show == nil) and (top.top_show == nil)) then
			minimalist_show = 0
			toggle()
		elseif ((left.left_show == 1) and (bottom.bottom_show == 1) and (top.top_show == 1)) then
			minimalist_show = 1
			toggle()
		elseif ((left.left_show == 0) and (bottom.bottom_show == 0) and (top.top_show == 0)) then
			minimalist_show = 0
			toggle()

		elseif((api.nvim_eval("&laststatus > 0 || &showtabline > 0") == 1) and (api.nvim_eval("&showtabline > 0") == 1) and (api.nvim_eval("&number > 0 || &relativenumber > 0") == 1)) then
			minimalist_show = 1
			toggle()

		elseif((api.nvim_eval("&laststatus > 0 || &showtabline > 0") == 0) and (api.nvim_eval("&showtabline > 0") == 0) and (api.nvim_eval("&number > 0 || &relativenumber > 0") == 0)) then
			minimalist_show = 0
			toggle()
		else
			minimalist_show = 1
			toggle()

			-- &laststatus > 0 || &showtabline > 0
			-- 1 if being shown
			-- 0 if being hidden
		-- nothing
		end
	end
end

-- function resume()

-- 	if (minimalist_show == 1) then				-- bottm true; shown
-- 		-- cmd("echo 'I was set to true so I am turning minimalist on'")
-- 		minimalist_true()
-- 	elseif (minimalist_show == 0) then			-- status line false; hidden
-- 		-- cmd("echo 'I was set to false so I am turning minimalist off'")
-- 		minimalist_false()
-- 	elseif (minimalist_show == nil) then			-- show var is nil
-- 		-- cmd("echo 'I was not set to anything so I am nil'")
-- 		minimalist_show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
-- 	else
-- 		cmd("echo 'none of the above'")
-- 		-- nothing
-- 	end
-- end


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
