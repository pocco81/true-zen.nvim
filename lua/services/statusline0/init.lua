

local service = require("services.statusline0.service")

-- show and hide statusline funcs
local function statusline_true()
	show = 1
	service.statusline_true()
end

local function statusline_false()
	show = 0
	service.statusline_false()
end


function resume()
	statusline_false()
end


function main(option)

	option = option or 0
	statusline_false()

	-- if (option == 0) then			-- toggle statuline (on/off)
	-- 	toggle()
	-- elseif (option == 1) then		-- show status line
	-- 	statusline_true()
	-- elseif (option == 2) then
	-- 	statusline_false()
	-- else
	-- 	-- not recognized
	-- end
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
