local M = {}

local service = require("true-zen.services.bottom.service")
local cmd = vim.cmd

-- show and hide bottom funcs
local function bottom_true()
	M.bottom_show = 1
	service.bottom_true()
end

local function bottom_false()
	M.bottom_show = 0
	service.bottom_false()
end

local function toggle()
	M.bottom_show = vim.api.nvim_eval("&laststatus > 0")
	if (M.bottom_show == 1) then				-- bottom true, shown; thus, hide
		bottom_false()
	elseif (M.bottom_show == 0) then			-- bottom false, hidden; thus, show
		bottom_true()
	else
		-- nothing
	end
end

function M.resume()

	if (M.bottom_show == 1) then				-- bottm true; shown
		bottom_true()
	elseif (M.bottom_show == 0) then			-- status line false; hidden
		bottom_false()
	elseif (M.bottom_show == nil) then			-- show var is nil
		M.bottom_show = vim.api.nvim_eval("&laststatus > 0")
		-- bottom_true()
	else
		cmd("echo 'none of the above'")
		-- nothing
	end
end


function M.main(option)

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

return M
