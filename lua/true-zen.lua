

local opts = require("config").options
-- local cmd = vim.cmd


local function setup_commands()

	require("config").set_options(custom_opts)
	if (opts.true_false_commands == true) then
		cmd("command! TZStatuslineT lua require'tz_main'.main(0, 1)")
		cmd("command! TZStatuslineF lua require'tz_main'.main(0, 2)")
	else
		-- do nothing
	end
end

function setup(custom_opts)
	setup_commands(custom_opts)
end




return {
	setup = setup
}
