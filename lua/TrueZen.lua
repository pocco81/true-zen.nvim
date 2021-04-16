

local statusline = require("services.statusline.init")


function main(option, command_option)

	option = option or 0
	command_option = command_option or 0

	if (option == 0) then
		statusline.main(command_option)
	elseif (option == 1) then
		--
	else
		-- command not recognized
	end


	
end

-- export the functions
return {
	-- toggle_statusline = toggle_statusline, -- called with TZStatusline
}

