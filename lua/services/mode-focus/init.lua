

local service = require("services.mode-focus.service")

local cmd = vim.cmd
local api = vim.api


-- show and hide focus funcs
local function focus_true()		-- focus window

	-- size_before = vim.api.nvim_eval("winrestcmd()")


	-- regardless of the window being focused or not, this will count the open windows
	local amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins == 1) then
		cmd("echo 'You can not focus this window because focusing a window only works when there are more than one.'")
		focus_show = 0
	elseif (amount_wins > 1) then
		focus_show = 1
		service.focus_true()
	end

end

local function focus_false()		-- unfocus window


	-- regardless of the window being focused or not, this will count the open windows
	local amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins == 1) then
		cmd("echo 'You can not unfocus this window because focusing a window only works when there are more than one.'")
		focus_show = 0
	elseif (amount_wins > 1) then
		focus_show = 0
		service.focus_false()
	end


end


windows_dimensions = {}

function check_win_size()

	local win_height = vim.api.nvim_eval("winheight('%')")
	local win_width = vim.api.nvim_eval("winheight('%')")

	table.insert(windows_dimensions, win_height)
	table.insert(windows_dimensions, win_width)

end

-- 1 = is focused
-- 0 = is not focused
local function toggle()

	if (focus_show ~= nil and focus_show == 1) then
	
		focus_false()
		
	elseif (focus_show ~= nil and focus_show == 0) then

		focus_true()
	
	elseif (focus_show == nil) then

		-- local amount_wins = vim.api.nvim_eval("winnr('$')")

		-- if (amount_wins > 1) then
		-- 	focus_true()
		-- end


		--[[
			the above will work, but in the case where user is already focusing a buffer
			and there are +1 windows. It'll fail

			This solution consists on going throuh eveyr buffer, getting ther size,
			comparing them with the current buffer's one!

			1. If the width and the height of every window is the same,
				focus current window.
			2. Get the height of every window, and add it up. Same with the width.
				Finally, compare it with the current window. If current window's
				dimensions are similar by an error margin of 5, unfocus
			3. 

			Add dimensions of every window. If similar to current one by a eror margin of 5 (3?),
			unfocus. else, focus.

			lines = width
			columns = height

			get vim session's height and width and add it up. Do the same for current window.

			difference = vin_session_size - current_win_size



			get vim session colum

		--]]--


		local amount_wins = vim.api.nvim_eval("winnr('$')")

		if (amount_wins > 1) then

			local current_session_height = vim.api.nvim_eval("&co")
			local current_session_width = vim.api.nvim_eval("&lines")
			local total_current_session = tonumber(current_session_width) + tonumber(current_session_height)
			
			local current_window_height = vim.api.nvim_eval("winheight('%')")
			local current_window_width = vim.api.nvim_eval("winwidth('%')")
			local total_current_window = tonumber(current_window_width) + tonumber(current_window_height)

			difference = total_current_session - total_current_window

			
			for i = 1, 7, 1 do

				if (difference == i) then
					-- since difference is small, it's assumable that window is focused
					focus_false()
					break
				elseif (i == 7) then
					-- difference is too big, it's assumable that window is not focused
					focus_true()
					break
				else
					-- nothing
				end
			end

			-- vim.api.nvim_exec([[
			-- 	" Like windo but restore the current window.
			-- 	function! WinDo(command)
			-- 		let currwin=winnr()
			-- 		execute 'windo ' . a:command
			-- 		execute currwin . 'wincmd w'
			-- 	endfunction

			-- 	com! -nargs=+ -complete=command Windo call WinDo(<q-args>)
			-- ]], false)
			
			-- cmd([[call WinDo("lua check_win_size()")]])

			-- local this_win_height = vim.api.nvim_eval("winheight('%')")
			-- local this_win_width = vim.api.nvim_eval("winwidth('%')")

			-- local total_height = 0
			-- local total_width = 0

			-- -- add up every heigth
			-- for i = 1, #windows_dimensions, 2 do
			-- 	total_height = total_height + tonumber(windows_dimensions[i])
			-- end

			-- -- add up every width
			-- for i = 2, #windows_dimensions, 2 do
			-- 	total_width = total_width + tonumber(windows_dimensions[i])
			-- end

			-- -- check if they are equal or similar
			-- if (total_height == this_win_height and total_width == this_win_height) then
			-- 	-- window is focused
			-- 	focus_false()
			-- else

			-- 	-- ex:				100				99
			-- 	-- height_difference = total_height - this_win_height
			-- 	-- width_difference = total_width - this_win_width

			-- 	-- screen_dimension = height_difference + width_difference

			-- 	total_screen_size = total_height + total_width
			-- 	total_window_size = this_win_height + this_win_width

			-- 	difference = total_screen_size - total_window_size

			-- 	if (difference == 0) then
			-- 		focus_false()
			-- 	else
			-- 		for i = 1, 10, 1 do
			-- 			-- comparte with height
			-- 			if (difference == i) then
			-- 				-- since difference is small, it's assumable that window is focused
			-- 				cmd("echo 'It was too small'")
			-- 				focus_false()
			-- 			elseif (i == 10) then
			-- 				-- difference is too big, it's assumable that window is not focused
			-- 				cmd("echo 'It was too big'")
			-- 				focus_true()
			-- 			end
			-- 		end
			-- 	end
			-- end

		else
			-- since there should always be at least one window
			focus_show = 0
			cmd("echo 'you can not (un)focus this window, because it is the only one!'")
		end

	end

end


function main(option)

	option = option or 0

	if (option == 0) then			-- toggle focus (on/off)
		toggle()
	elseif (option == 1) then		-- focus window
		focus_true()
	elseif (option == 2) then		-- unfocus window
		focus_false()
	else
		-- not recognized
	end
end


return {
	main = main
}
