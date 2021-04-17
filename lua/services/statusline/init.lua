
-- imports
-- TrueZen
local service = require("services.statusline.service")
-- local api = vim.api

-- vars
Is_statusline_shown = true

local function toggle()

	if (Is_statusline_shown == true) then
		service.statusline_false()
		Is_statusline_shown = false
	elseif (Is_statusline_shown == false) then
		service.statusline_true()
		Is_statusline_shown = true
	else
		-- nothing
	end
end

local function statusline_true()
	service.statusline_true()
end

local function statusline_false()
	service.statusline_false()
end

-- reset state on resume / focus gained
function resume()

	cmd("echo 'Vim was resumed...'")
	if (Is_statusline_shown == true) then
		service.statusline_true()
	elseif (Is_statusline_shown == false) then
		service.statusline_false()
	else
		-- nothing
	end
end

function main(option)
	
	option = option or 0

	if (option == 0) then			-- toggle statuline (on/off)
		toggle()
	elseif (option == 1) then		-- show status line
		statusline_true()
	elseif (option == 2) then
		statusline_false()
	else
		-- not recognized
	end
end

vim.api.nvim_exec([[
	augroup toggle_statusline
		autocmd!
		autocmd VimResume,FocusGained * lua resume()
	augroup END
]], false)


return {
	main = main
}



