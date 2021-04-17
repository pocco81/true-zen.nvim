
-- imports
-- TrueZen
local service = require("services.statusline.service")
-- local api = vim.api
local cmd = vim.cmd

local function get(var, default)
	if (var) then
		return var
	else
		return default
	end
end





local function is_shown()
	return get(show, 0)
end

-- show and hide statusline funcs
local function statusline_true()
	show = 1
	service.statusline_true()
end

local function statusline_false()
	show = 0
	service.statusline_false()
end


local function toggle()

	if (is_shown() == 1) then
		statusline_false()
	elseif ((is_shown() == 0)) then
		statusline_true()
	else
		-- nothing
	end
end

function resume()
	if (is_shown() == 1) then
		statusline_true()
	elseif ((is_shown() == 0)) then
		statusline_false()
	else
		-- nothing
	end
end



function main(option)

	if (toggle_line_show) then		-- if var exists
		-- global to script
		show = get(toggle_line_show, 0)
	else		-- var does not exist
		-- global to script
		show = vim.api.nvim_eval("&laststatus > 0 || &showtabline > 0")
		-- returns 1 if statusline shown
		-- returns 0 if statusline is hidden
		-- check this: echo &laststatus > 0 || &showtabline > 0
	end

	
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


-- vars
-- local Is_statusline_shown = true

-- local function toggle()

-- 	if (Is_statusline_shown == true) then
-- 		service.statusline_false()
-- 		Is_statusline_shown = false
-- 	elseif (Is_statusline_shown == false) then
-- 		service.statusline_true()
-- 		Is_statusline_shown = true
-- 	else
-- 		-- nothing
-- 	end
-- end


-- reset state on resume / focus gained
-- function resume()

-- 	local to_cmd = "echo 'Vim was resumen, current status is -"..tostring(Is_statusline_shown).."-'"
-- 	cmd(to_cmd)		-- working
-- 	if (Is_statusline_shown == true) then
-- 		service.statusline_true()
-- 	elseif (Is_statusline_shown == false) then
-- 		service.statusline_false()
-- 	else
-- 		-- nothing
-- 	end
-- end

-- function main(option)
	
-- 	option = option or 0

-- 	if (option == 0) then			-- toggle statuline (on/off)
-- 		toggle()
-- 	elseif (option == 1) then		-- show status line
-- 		statusline_true()
-- 	elseif (option == 2) then
-- 		statusline_false()
-- 	else
-- 		-- not recognized
-- 	end
-- end

-- vim.api.nvim_exec([[
-- 	augroup toggle_statusline
-- 		autocmd!
-- 		autocmd VimResume,FocusGained * lua resume()
-- 	augroup END
-- ]], false)


-- return {
-- 	main = main
-- }



