local M = {}

local service = require("true-zen.services.left.service")
local cmd = vim.cmd

-- show and hide left funcs
local function left_true()
	M.left_show = 1
	service.left_true()
end

local function left_false()
	M.left_show = 0
	service.left_false()
end

local function toggle()

	if (M.left_show == 1) then				-- left true; being shown
		left_false()
	elseif (M.left_show == 0) then			-- left false; being hidden
		left_true()
	elseif (M.left_show == nil) then			-- show var is nil
		M.left_show = vim.api.nvim_eval("&number > 0 || &relativenumber > 0")
		if (vim.api.nvim_eval("&number > 0 || &relativenumber > 0") == 1) then
			M.left_show = 1
			toggle()
		elseif (vim.api.nvim_eval("&signcolumn") == "yes") then
			M.left_show = 1
			toggle()
		else
			M.left_show = 0
			toggle()
		end
	else
		cmd("echo 'none of the above'")
		-- nothing
	end



end

function M.resume()

	if (M.left_show == 1) then				-- left true; shown
		left_true()
	elseif (M.left_show == 0) then			-- left false; hidden
		left_false()
	elseif (M.left_show == nil) then			-- show var is nil
		M.left_show = vim.api.nvim_eval("&number > 0 || &relativenumber > 0")
		if (vim.api.nvim_eval("&number > 0 || &relativenumber > 0") == 1) then
			M.left_show = 1
			M.resume()
		elseif (vim.api.nvim_eval("&signcolumn") == "yes") then
			M.left_show = 1
			M.resume()
		else
			M.left_show = 0
			M.resume()
		end
	else
		cmd("echo 'none of the above'")
		-- nothing
	end
end


function M.main(option)

	option = option or 0

	if (option == 0) then			-- toggle left (on/off)
		toggle()
	elseif (option == 1) then		-- show left
		left_true()
	elseif (option == 2) then
		left_false()
	else
		-- not recognized
	end
end


return M
