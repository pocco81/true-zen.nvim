

local service = require("services.bottom.service")
local cmd = vim.cmd

-- show and hide bottom funcs
local function bottom_true()
	bottom_show = 1
	service.bottom_true()
end

local function bottom_false()
	bottom_show = 0
	service.bottom_false()
end

local function toggle()
	bottom_show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
	if (bottom_show == 1) then				-- bottom true, shown; thus, hide
		bottom_false()
	elseif (bottom_show == 0) then			-- bottom false, hidden; thus, show
		bottom_true()
	else
		-- nothing
	end
end

function resume()

	if (bottom_show == 1) then				-- bottm true; shown
		-- cmd("echo 'I was set to true so I am turning bottom on'")
		bottom_true()
	elseif (bottom_show == 0) then			-- status line false; hidden
		-- cmd("echo 'I was set to false so I am turning bottom off'")
		bottom_false()
	elseif (bottom_show == nil) then			-- show var is nil
		-- cmd("echo 'I was not set to anything so I am nil'")
		bottom_show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
	else
		cmd("echo 'none of the above'")
		-- nothing
	end
end


function main(option)

	option = option or 0

	if (option == 0) then			-- toggle statuline (on/off)
		toggle()
	elseif (option == 1) then		-- show status line
		bottom_true()
	elseif (option == 2) then
		bottom_false()
	else
		-- not recognized
	end
end


-- vim.api.nvim_exec([[
-- 	augroup toggle_statusline
-- 		autocmd!
-- 		autocmd VimResume,FocusGained * lua resume()
-- 	augroup END
-- ]], false)

return {
	main = main,
	resume = resume,
	bottom_show = bottom_show
}
