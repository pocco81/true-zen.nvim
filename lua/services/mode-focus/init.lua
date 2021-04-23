

local service = require("services.mode-focus.service")
local opts = require("config").options

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

-- 1 = is focused
-- 0 = is not focused
local function toggle()

	if (focus_show ~= nil and focus_show == 1) then
	
		focus_false()
		
	elseif (focus_show ~= nil and focus_show == 0) then

		focus_true()
	
	elseif (focus_show == nil) then

		local amount_wins = vim.api.nvim_eval("winnr('$')")

		if (amount_wins > 1) then

			local current_session_height = vim.api.nvim_eval("&co")
			local current_session_width = vim.api.nvim_eval("&lines")
			local total_current_session = tonumber(current_session_width) + tonumber(current_session_height)
			
			local current_window_height = vim.api.nvim_eval("winheight('%')")
			local current_window_width = vim.api.nvim_eval("winwidth('%')")
			local total_current_window = tonumber(current_window_width) + tonumber(current_window_height)

			difference = total_current_session - total_current_window

			
			for i = 1, tonumber(opts["focus"]["margin_of_error"]), 1 do

				if (difference == i) then
					-- since difference is small, it's assumable that window is focused
					focus_false()
					break
				elseif (i == tonumber(opts["focus"]["margin_of_error"])) then
					-- difference is too big, it's assumable that window is not focused
					focus_true()
					break
				else
					-- nothing
				end
			end

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
