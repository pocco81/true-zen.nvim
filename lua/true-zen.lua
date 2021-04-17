

local opts = require("config").options
local statusline = require("services.statusline.init")
local cmd  = vim.cmd

function setup(custom_opts)
	cmd("echo 'TrueZen.nvim was set up...'")		-- working...
	require("config").set_options(custom_opts)
	if (opts.true_false_commands == true) then
		cmd("command! TZStatuslineF lua require'TrueZen'.main(0, 2)")
		cmd("command! TZStatuslineT lua require'TrueZen'.main(0, 1)")
	else
		-- nothing
	end
end


function main(option, command_option)

	option = option or 0
	command_option = command_option or 0

	if (option == 0) then
		statusline.main(command_option)
	elseif (option == 1) then
		cmd("echo '1 was given'")
	else
		-- command not recognized
	end


	
end


-- export the functions
return {
	-- toggle_statusline = toggle_statusline, -- called with TZStatusline
	main = main,
	setup = setup
}

