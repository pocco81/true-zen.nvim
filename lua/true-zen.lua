

local opts = require("config").options
local bottom = require("services.bottom.init")
local top = require("services.top.init")
local left = require("services.left.init")

local resume = require("services.resume.init")
local cmd  = vim.cmd

-- cmd("source services/resume/init.vim")

-- function setup(custom_opts)
-- 	require("config").set_options(custom_opts)
	-- if (opts.true_false_commands == true) then
	-- 	cmd("command! TZStatuslineT lua main(0, 1)")
	-- 	cmd("command! TZStatuslineF lua main(0, 2)")
	-- else
	-- 	-- do nothing
	-- end
-- end

-- 	if (opts.setup_message == true) then
-- 		cmd("echo 'TrueZen.nvim was set up...'")		-- working...
-- 	elseif (opts.setup_message == false) then
-- 		-- do nothing
-- 	else
-- 		-- do nothing
-- 	end
-- end

-- if (opts.true_false_commands == true) then
-- 	cmd("command! TZStatuslineT lua main(0, 1)")
-- 	cmd("command! TZStatuslineF lua main(0, 2)")
-- else
-- 	-- do nothing
-- end


function main(option, command_option)

	option = option or 0
	command_option = command_option or 0

	if (option == 0) then
		bottom.main(command_option)
	elseif (option == 1) then
		top.main(command_option)
	elseif (option == 2) then
		left.main(command_option)
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

