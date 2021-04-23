

local service = require("true-zen.services.left.service")
local cmd = vim.cmd

-- show and hide left funcs
local function left_true()
	left_show = 1
	service.left_true()
end

local function left_false()
	left_show = 0
	service.left_false()
end

local function toggle()
	left_show = vim.api.nvim_eval("&number > 0 || &relativenumber > 0")
	if (left_show == 1) then				-- left true, shown; thus, hide
		left_false()
	elseif (left_show == 0) then			-- left false, hidden; thus, show
		left_true()
	else
		-- nothing
	end
end

function resume()

	if (left_show == 1) then				-- left true; shown
		left_true()
	elseif (left_show == 0) then			-- left false; hidden
		left_false()
	elseif (left_show == nil) then			-- show var is nil
		left_show = vim.api.nvim_eval("&number > 0 || &relativenumber > 0")
		resume()
	else
		cmd("echo 'none of the above'")
		-- nothing
	end
end


function main(option)

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


return {
	main = main,
	resume = resume,
	left_show = left_show
}
