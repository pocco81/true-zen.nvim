

local opts = require("config").options
local cmd = vim.cmd


local function setup_commands()

	if (opts.true_false_commands == true) then
		cmd("command! TZBottomT lua require'tz_main'.main(0, 1)")
		cmd("command! TZBottomF lua require'tz_main'.main(0, 2)")
		cmd("command! TZMinimalistT lua require'tz_main'.main(3, 1)")
		cmd("command! TZMinimalistF lua require'tz_main'.main(3, 2)")
		cmd("command! TZAtaraxisT lua require'tz_main'.main(4, 1)")
		cmd("command! TZAtaraxisF lua require'tz_main'.main(4, 2)")
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

function setup(custom_opts)
	require("config").set_options(custom_opts)
	setup_commands()
	setup_cursor()
end



return {
	setup = setup
}
