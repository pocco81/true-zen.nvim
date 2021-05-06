

local opts = require("true-zen.config").options
local left_service = require("true-zen.services.left.service")
local mode_minimalist = require("true-zen.services.mode-minimalist.init")
local before_after_cmds = require("true-zen.utils.before_after_cmd")

local hi_group = require("true-zen.services.mode-ataraxis.modules.hi_group")
local fillchar = require("true-zen.services.mode-ataraxis.modules.fillchar")


local cmd = vim.cmd



vim.api.nvim_exec([[
	" Like bufdo but restore the current buffer.
	function! BufDo(command)
		let currBuff=bufnr("%")
		execute 'bufdo ' . a:command
		execute 'buffer ' . currBuff
	endfunction
	com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

	" escape backward slash
	" mental note: don't use simple quotation marks
	" call BufDo("set fillchars+=vert:\\ ")

	" since the function is global, it can be called outside of this nvim_exec statement like so:
	" vim.cmd([[call BufDo("set fillchars+=vert:\\ "
	" don't forget to complete the statement, is just becuase I can't do that within nvim_exec statement
]], false)




function load_integrations(state)

	state = state or false

	if (state == true) then

		for opt, _ in pairs(opts["integrations"]) do
			if (opts["integrations"][opt] == true) then
				if (opt == "integration_galaxyline") then
					require("true-zen.services.bottom.integrations.integration_galaxyline").enable_element()
					has_statusline_with_integration = true
				elseif (opt == "integration_gitgutter") then

					local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

					if (is_gitgutter_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_gitgutter").enable_element()
					elseif (is_gitgutter_running == 1) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_vim_signify") then


					local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

					if (is_vim_signify_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_signify").enable_element()
					elseif (is_vim_signify_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_tmux") then
				
					local is_tmux_running = vim.api.nvim_eval("$TMUX")

					if (is_tmux_running ~= "") then		-- is running
						require("true-zen.services.bottom.integrations.integration_tmux").enable_element()
					else
						-- tmux wasn't running
					end

				elseif (opt == "integration_vim_airline") then


					local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

					if (is_vim_airline_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_airline").enable_element()
					elseif (is_vim_airline_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_vim_powerline") then


					local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

					if (is_vim_powerline_running == 0) then		-- is not running
						require("true-zen.services.bottom.integrations.integration_vim_powerline").enable_element()
					elseif (is_vim_powerline_running == 1) then		-- is running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_express_line") then

					require("true-zen.services.bottom.integrations.integration_express_line").enable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_limelight") then

					require("true-zen.services.bottom.integrations.integration_limelight").disable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_gitsigns") then

					local gs_integration = require("true-zen.services.bottom.integrations.integration_gitsigns")
					local gs_config = require("gitsigns")._get_config()


					if (gs_ps_current_line_blame == nil) then
						gs_integration.toggle_element(0)
					else
						if (gs_ps_current_line_blame == false) then
							-- it's already false
						end
					end

					if (gs_ps_numhl == nil) then
						gs_integration.toggle_element(1)
					else
						if (gs_ps_current_line_blame == false) then
							-- it's already false
						end
					end

					if (gs_ps_linehl == nil) then
						gs_integration.toggle_element(2)
					else
						if (gs_ps_linehl == false) then
							-- it's already false
						end
					end

					if (gs_ps_signs == nil) then
						gs_integration.toggle_element(3)
					else
						if (gs_ps_signs == false) then
							-- it's already false
						end
					end

				else
					-- integration not recognized
				end
			else
				-- ignore it
			end
		end
	
	elseif (state == false) then
		
		for opt, _ in pairs(opts["integrations"]) do
			if (opts["integrations"][opt] == true) then
				if (opt == "integration_galaxyline") then

					require("true-zen.services.bottom.integrations.integration_galaxyline").disable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_gitgutter") then

					local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

					if (is_gitgutter_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_gitgutter").disable_element()
					elseif (is_gitgutter_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_vim_signify") then

					local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

					if (is_vim_signify_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_signify").disable_element()
					elseif (is_vim_signify_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

				elseif (opt == "integration_tmux") then

					local is_tmux_running = vim.api.nvim_eval("$TMUX")

					if (is_tmux_running ~= "") then
						require("true-zen.services.bottom.integrations.integration_tmux").disable_element()
					else
						-- tmux wasn't running
					end


				elseif (opt == "integration_vim_airline") then

					local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

					if (is_vim_airline_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_airline").disable_element()
					elseif (is_vim_airline_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true

				elseif (opt == "integration_vim_powerline") then

					local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

					if (is_vim_powerline_running == 1) then		-- is running
						require("true-zen.services.bottom.integrations.integration_vim_powerline").disable_element()
					elseif (is_vim_powerline_running == 0) then		-- is not running
						-- nothing
					else
						-- nothing either
					end

					has_statusline_with_integration = true


				elseif (opt == "integration_express_line") then

					require("true-zen.services.bottom.integrations.integration_express_line").disable_element()

					has_statusline_with_integration = true

				elseif (opt == "integration_limelight") then

					require("true-zen.services.bottom.integrations.integration_limelight").enable_element()

					has_statusline_with_integration = true
		
				elseif (opt == "integration_gitsigns") then
					local gs_integration = require("true-zen.services.bottom.integrations.integration_gitsigns")
					local gs_config = require("gitsigns")._get_config()

					gs_ps_current_line_blame = nil
					gs_ps_numhl = nil
					gs_ps_linehl = nil
					gs_ps_signs = nil

					if (gs_config.current_line_blame == true) then
						gs_integration.toggle_element(0)
					else
						gs_ps_current_line_blame = false
					end
					
					if (gs_config.numhl == true) then
						gs_integration.toggle_element(1)
					else
						gs_ps_numhl = false
					end
					
					if (gs_config.linehl == true) then
						gs_integration.toggle_element(2)
					else
						gs_ps_linehl = false
					end

					if (gs_config.signs == true) then
						gs_integration.toggle_element(3)
					else
						gs_ps_signs = false
					end

				else
					-- integration not recognized
				end
			else
				-- ignore it
			end
		end

	end
	
end


function ataraxis_true()		-- show

	local amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins == 1) then
		cmd("echo 'TrueZen: can not exit Ataraxi Mode because you are currently not in it'")
	elseif (amount_wins > 1) then
		cmd("wincmd h")
		cmd("q")
		cmd("wincmd l")
		cmd("q")


		if (opts["ataraxis"]["top_padding"] > 0) then
			cmd("wincmd k")
			cmd("q")
		else
			-- nothing
		end

		if (opts["ataraxis"]["bottom_padding"] > 0) then
			cmd("wincmd j")
			cmd("q")
		else
			-- nothing
		end

		-- mode_minimalist.main(1)
		cmd("set fillchars=")

		-- if removed, it's likely that numberline and bottom will be removed
		cmd([[call BufDo("lua require'true-zen.services.left.init'.main(1)")]])
	end


	--------------------------=== Splits stuff ===--------------------------
		-- return splitbelow and splitright to user settings:
	if (is_splitbelow_set == 1) then
		-- it's already set
		-- cmd("set splitbelow")
	elseif (is_splitbelow_set == 0) then
		cmd("set nosplitbelow")
	end


	if (is_splitright_set == 1) then
		-- it's already set
		-- cmd("set splitright")
	elseif (is_splitright_set == 0) then
		cmd("set nosplitright")
	end
	--------------------------=== Splits stuff ===--------------------------


	--------------------------=== Fill chars ===--------------------------

	if (opts["ataraxis"]["disable_fillchars_configuration"] == false) then
		fillchar.restore_fillchars()
	else
		-- nothing
	end

	--------------------------=== Fill chars ===--------------------------


	--------------------------=== Hi Groups ===--------------------------

	if (opts["ataraxis"]["disable_bg_configuration"] == false) then
		hi_group.restore_hi_groups()
	else
		-- nothing
	end

	--------------------------=== Hi Groups ===--------------------------


	if (has_statusline_with_integration == true) then
		-- ignore
	else
		cmd("setlocal statusline="..current_statusline.."")
	end



	-------------------------=== Integrations ===------------------------
	vim.api.nvim_exec([[
		augroup false_integrations
			autocmd!
		augroup END
	]], false)


	load_integrations(true)


	vim.api.nvim_exec([[
		augroup true_integrations
			autocmd!
			autocmd BufWinEnter * if (&modifiable == 1) | execute "lua load_integrations(true)" | endif
		augroup END
	]], false)
	-------------------------=== Integrations ===------------------------


		mode_minimalist.main(1)


end


function ataraxis_false()		-- hide

	local amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins > 1) then
		if (opts["ataraxis"]["force_when_plus_one_window"] == false) then
			cmd("echo 'TrueZen: TZAtaraxis can not be toggled if there is more than one window open. However, you can force it with the force_when_plus_one_window setting'")
			goto there_was_more_than_one_window
		elseif (opts["ataraxis"]["force_when_plus_one_window"] == true) then
			cmd("only")
		end
	else
		-- nothing

	end


	---------------- solves: Vim(Buffer): E86: Buffer 3 does not exist
	is_splitbelow_set = vim.api.nvim_eval("&splitbelow")
	is_splitright_set = vim.api.nvim_eval("&splitright")

	if (is_splitbelow_set == 0 or is_splitright_set == 0) then
		cmd("set splitbelow")
		cmd("set splitright")
	else
		-- continue
	end
	---------------- solves: Vim(Buffer): E86: Buffer 3 does not exist

	if (opts["minimalist"]["store_and_restore_settings"] == true) then

		top_has_been_stored = before_after_cmds.get_has_been_stored("TOP")
		bottom_has_been_stored = before_after_cmds.get_has_been_stored("BOTTOM")
		left_has_been_stored = before_after_cmds.get_has_been_stored("LEFT")

		if not (top_has_been_stored == true) then
			before_after_cmds.store_settings(opts["top"],"TOP")
		end

		if not (bottom_has_been_stored == true) then
			before_after_cmds.store_settings(opts["bottom"],"BOTTOM")
		end

		if not (left_has_been_stored == true) then
			before_after_cmds.store_settings(opts["left"],"LEFT")
		end
	
	end




	---------------------------=== Integrations ===------------------------
	--vim.api.nvim_exec([[
	--	augroup true_integrations
	--		autocmd!
	--	augroup END
	--]], false)

	--load_integrations(false)
	---------------------------=== Integrations ===------------------------

	-- local tz_top_padding = vim.api.nvim_eval([[exists("g:tz_top_padding")]])
	-- local tz_left_padding = vim.api.nvim_eval([[exists("g:tz_left_padding")]])
	-- local tz_right_padding = vim.api.nvim_eval([[exists("g:tz_right_padding")]])
	-- local tz_bottom_padding = vim.api.nvim_eval([[exists("g:tz_bottom_padding")]])

	local tz_top_padding = vim.api.nvim_eval([[get(g:,"tz_top_padding", "NONE")]])
	local tz_left_padding = vim.api.nvim_eval([[get(g:,"tz_left_padding", "NONE")]])
	local tz_right_padding = vim.api.nvim_eval([[get(g:,"tz_right_padding", "NONE")]])
	local tz_bottom_padding = vim.api.nvim_eval([[get(g:, "tz_bottom_padding", "NONE")]])


	local left_padding_cmd = ""
	local right_padding_cmd = ""
	local top_padding_cmd = ""
	local bottom_padding_cmd = ""

	if not (tz_left_padding == "NONE" and tz_right_padding == "NONE") then
		left_padding_cmd = "vertical resize "..tz_left_padding..""
		right_padding_cmd = "vertical resize "..tz_right_padding..""
	else

		if (opts["ataraxis"]["ideal_writing_area_width"] > 0) then
			-- stuff
			local window_width = vim.api.nvim_eval("winwidth('%')")
			local ideal_writing_area_width = opts["ataraxis"]["ideal_writing_area_width"]

			if (ideal_writing_area_width == window_width) then
				cmd("echo 'TrueZen: the ideal_writing_area_width setting cannot have the same size as your current window, it must be smaller than "..window_width.."'")
			else
				total_left_right_width = window_width - ideal_writing_area_width
				
				if (total_left_right_width % 2 > 0) then
					total_left_right_width = total_left_right_width + 1
				end

				local calculated_left_padding = total_left_right_width / 2
				local calculated_right_padding = total_left_right_width / 2

				left_padding_cmd = "vertical resize "..calculated_left_padding..""
				right_padding_cmd = "vertical resize "..calculated_right_padding..""

			end
		else
			if (opts["ataraxis"]["just_do_it_for_me"] == true) then
				-- calculate padding
				local calculated_left_padding = vim.api.nvim_eval("winwidth('%') / 4")
				local calculated_right_padding = vim.api.nvim_eval("winwidth('%') / 4")

				-- set padding
				left_padding_cmd = "vertical resize "..calculated_left_padding..""
				right_padding_cmd = "vertical resize "..calculated_right_padding..""

			else
				-- stuff
				left_padding_cmd = "vertical resize "..opts["ataraxis"]["left_padding"]..""
				right_padding_cmd = "vertical resize "..opts["ataraxis"]["right_padding"]..""
			end
		end

	end

	-- if (opts["ataraxis"]["ideal_writing_area_width"] > 0) then
	-- 	-- stuff
	-- 	local window_width = vim.api.nvim_eval("winwidth('%')")
	-- 	local ideal_writing_area_width = opts["ataraxis"]["ideal_writing_area_width"]

	-- 	if (ideal_writing_area_width == window_width) then
	-- 		cmd("echo 'TrueZen: the ideal_writing_area_width setting cannot have the same size as your current window, it must be smaller than "..window_width.."'")
	-- 	else
	-- 		total_left_right_width = window_width - ideal_writing_area_width
			
	-- 		if (total_left_right_width % 2 > 0) then
	-- 			total_left_right_width = total_left_right_width + 1
	-- 		end

	-- 		local calculated_left_padding = total_left_right_width / 2
	-- 		local calculated_right_padding = total_left_right_width / 2

	-- 		left_padding_cmd = "vertical resize "..calculated_left_padding..""
	-- 		right_padding_cmd = "vertical resize "..calculated_right_padding..""

	-- 	end
	-- else
	-- 	if (opts["ataraxis"]["just_do_it_for_me"] == true) then
	-- 		-- calculate padding
	-- 		local calculated_left_padding = vim.api.nvim_eval("winwidth('%') / 4")
	-- 		local calculated_right_padding = vim.api.nvim_eval("winwidth('%') / 4")

	-- 		-- set padding
	-- 		left_padding_cmd = "vertical resize "..calculated_left_padding..""
	-- 		right_padding_cmd = "vertical resize "..calculated_right_padding..""

	-- 	else
	-- 		-- stuff
	-- 		left_padding_cmd = "vertical resize "..opts["ataraxis"]["left_padding"]..""
	-- 		right_padding_cmd = "vertical resize "..opts["ataraxis"]["right_padding"]..""
	-- 	end
	-- end


	-------------------- left buffer
	cmd("leftabove vnew")
	cmd(left_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	-- fillchars()
	-------------------- left buffer




	-- return to middle buffer
	cmd("wincmd l")




	-------------------- right buffer
	cmd("vnew")
	cmd(right_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	-- fillchars()
	-------------------- right buffer



	-- return to middle buffer
	cmd("wincmd h")




	if not (tz_top_padding == "NONE") then
		top_padding_cmd = "resize "..tz_top_padding..""
		cmd("leftabove new")
		cmd(top_padding_cmd)
		cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")

		cmd("unlet g:tz_top_padding")

		-- return to middle buffer
		cmd("wincmd j")
	else
		if (opts["ataraxis"]["top_padding"] > 0) then
			-- local top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
			top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
			cmd("leftabove new")
			cmd(top_padding_cmd)
			cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
			-- fillchars()

			-- return to middle buffer
			cmd("wincmd j")
		elseif (opts["ataraxis"]["top_padding"] == 0) then
			-- do nothing
		else
			cmd("echo 'invalid option set for top_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
		end
	end
	
	-- if (opts["ataraxis"]["top_padding"] > 0) then
	-- 	-- local top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
	-- 	top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
	-- 	cmd("leftabove new")
	-- 	cmd(top_padding_cmd)
	-- 	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	-- 	-- fillchars()

	-- 	-- return to middle buffer
	-- 	cmd("wincmd j")
	-- elseif (opts["ataraxis"]["top_padding"] == 0) then
	-- 	-- do nothing
	-- else
	-- 	cmd("echo 'invalid option set for top_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
	-- end



	if not (tz_bottom_padding == "NONE") then

		bottom_padding_cmd = "resize "..tz_bottom_padding..""
		cmd("rightbelow new")
		cmd(bottom_padding_cmd)
		cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")

		-- return to middle buffer
		cmd("wincmd k")
	else
		if (opts["ataraxis"]["bottom_padding"] > 0) then
			-- local bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
			bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
			cmd("rightbelow new")
			cmd(bottom_padding_cmd)
			cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
			-- fillchars()

			-- return to middle buffer
			cmd("wincmd k")
		elseif (opts["ataraxis"]["bottom_padding"] == 0) then
			-- do nothing
		else
			cmd("echo 'invalid option set for bottom_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
		end
	end


	-- if (opts["ataraxis"]["bottom_padding"] > 0) then
	-- 	-- local bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
	-- 	bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
	-- 	cmd("rightbelow new")
	-- 	cmd(bottom_padding_cmd)
	-- 	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	-- 	-- fillchars()

	-- 	-- return to middle buffer
	-- 	cmd("wincmd k")
	-- elseif (opts["ataraxis"]["bottom_padding"] == 0) then
	-- 	-- do nothing
	-- else
	-- 	cmd("echo 'invalid option set for bottom_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
	-- end


	--------------------------=== Fill chars ===--------------------------

	if (opts["ataraxis"]["disable_fillchars_configuration"] == false) then
		fillchar.store_fillchars()
		fillchar.set_fillchars()
	else
		-- nothing
	end

	--------------------------=== Fill chars ===--------------------------


	mode_minimalist.main(2)

	-------------------------=== Integrations ===------------------------
	vim.api.nvim_exec([[
		augroup true_integrations
			autocmd!
		augroup END
	]], false)

	load_integrations(false)
	-------------------------=== Integrations ===------------------------

	-- remove the border lines on every buffer
	-- cmd([[call BufDo("set fillchars+=vert:\\ ")]])

	-- hide whatever the user set to be hidden on the left hand side of vim
	cmd([[call BufDo("lua require'true-zen.services.left.init'.main(2)")]])

	--------------------------=== Hi Groups ===--------------------------

	if (opts["ataraxis"]["disable_bg_configuration"] == false) then
		hi_group.store_hi_groups()
		hi_group.set_hi_groups(opts["ataraxis"]["custome_bg"])
	else
		-- nothing
	end

	--------------------------=== Hi Groups ===--------------------------


	-- statusline stuff
	if (has_statusline_with_integration == true) then
		-- ignore
	else
		current_statusline = vim.api.nvim_eval("&statusline")
		cmd("setlocal statusline=-")
		-- goto no_need_to_force_hide_again
	end

	if (opts["ataraxis"]["force_hide_statusline"] == true) then
		cmd("setlocal statusline=-")
		cmd("echo 'I RAN'")
	end

	-- if it was already forced
	-- ::no_need_to_force_hide_again::



	-------------------------=== Integrations ===------------------------
	vim.api.nvim_exec([[
		augroup false_integrations
			autocmd!
			autocmd BufWinEnter * if (&modifiable == 1) | execute "lua load_integrations(false)" | endif
		augroup END
	]], false)
	-------------------------=== Integrations ===------------------------


	-- everything will be skipped if there was more than one window open
	::there_was_more_than_one_window::

end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
