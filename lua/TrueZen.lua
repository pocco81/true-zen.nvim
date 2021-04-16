

local statusline = require("services.statusline.init")
local cmd  = vim.cmd


function main(option, command_option)

	option = option or 0
	command_option = command_option or 0

	if (option == 0) then
		-- statusline.main(command_option)
		cmd("echo '0 was given'")
	elseif (option == 1) then
		cmd("echo '1 was given'")
	else
		-- command not recognized
	end


	
end

-- export the functions
return {
	-- toggle_statusline = toggle_statusline, -- called with TZStatusline
}

