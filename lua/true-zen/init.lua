local M = {}

local opts = require("true-zen.config").options
local cmd = vim.cmd


local function setup_commands()


	-- top, left
	if (opts.true_false_commands == true) then

	-- UI components
		cmd("command! TZTopT lua require'true-zen.main'.main(1, 1)")
		cmd("command! TZTopF lua require'true-zen.main'.main(1, 2)")
		cmd("command! TZLeftT lua require'true-zen.main'.main(2, 1)")
		cmd("command! TZLeftF lua require'true-zen.main'.main(2, 2)")
		cmd("command! TZBottomT lua require'true-zen.main'.main(0, 1)")
		cmd("command! TZBottomF lua require'true-zen.main'.main(0, 2)")

		-- Modes
		cmd("command! TZMinimalistT lua require'true-zen.main'.main(3, 1)")
		cmd("command! TZMinimalistF lua require'true-zen.main'.main(3, 2)")
		cmd("command! TZAtaraxisT lua require'true-zen.main'.main(4, 1)")
		cmd("command! TZAtaraxisF lua require'true-zen.main'.main(4, 2)")

		-- Modes
		cmd("command! TZMinimalistT lua require'true-zen.main'.main(3, 1)")
		cmd("command! TZMinimalistF lua require'true-zen.main'.main(3, 2)")
		cmd("command! TZAtaraxisT lua require'true-zen.main'.main(4, 1)")
		cmd("command! TZAtaraxisF lua require'true-zen.main'.main(4, 2)")
		cmd("command! TZFocusT lua require'true-zen.main'.main(5, 1)")
		cmd("command! TZFocusF lua require'true-zen.main'.main(5, 2)")

	elseif (opts.true_false_commands == false) then
		-- nothing
	else
		cmd("echo 'true_false_commands' option was not set correctly for TrueZen.nvim plugin")
	end
end

local function setup_cursor()

	if (opts.cursor_by_mode == true) then
		cmd("set guicursor=i-c-ci:ver25,o-v-ve:hor20,cr-sm-n-r:block")
	elseif (opts.cursor_by_mode == false) then
		-- nothing
	else
		cmd("echo 'cursor_by_mode' option was not set correctly for TrueZen.nvim plugin")
	end
end


function M.before_minimalist_mode_shown()
	
end

function M.before_minimalist_mode_hidden()
	
end

function M.after_minimalist_mode_shown()
	
end

function M.after_minimalist_mode_hidden()
	
end


function M.setup(custom_opts)
	require("true-zen.config").set_options(custom_opts)
	setup_commands()
	setup_cursor()
end



return M
