

local opts = require("config").options
local left_service = require("services.left.service")
local mode_minimalist = require("services.mode-minimalist.init")


local cmd = vim.cmd



-- integration test
in_galaxyline = true



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


local function fillchars()
	cmd([[set fillchars+=vert:\ ]])
	cmd([[set fillchars+=stl:\ ]])
	cmd([[set fillchars+=stlnc:\ ]])
end

function ataraxis_true()		-- show

	amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins == 1) then
		cmd("echo 'Can not exit Ataraxi Mode because you are currently not in it'")
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
			-- do nothing
		end

		mode_minimalist.main(1)
		cmd("set fillchars=")
		cmd([[call BufDo("lua require'services.left.init'.main(1)")]])
	end


	for opt, _ in pairs(opts["integrations"]) do
		if (opts["integrations"][opt] == true) then
			if (opt == "integration_galaxyline") then
				require("services.bottom.integrations.integration_galaxyline").enable_element()
			elseif (opt == "integration_gitgutter") then

				local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

				if (is_gitgutter_running == 0) then		-- is not running
					require("services.bottom.integrations.integration_gitgutter").enable_element()
				elseif (is_gitgutter_running == 1) then		-- is not running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_vim_signify") then


				local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

				if (is_vim_signify_running == 0) then		-- is not running
					require("services.bottom.integrations.integration_vim_signify").enable_element()
				elseif (is_vim_signify_running == 1) then		-- is running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_tmux") then
			
				local is_tmux_running = vim.api.nvim_eval("$TMUX")

				if (is_tmux_running ~= "") then		-- is running
					require("services.bottom.integrations.integration_tmux").enable_element()
				else
					-- tmux wasn't running
				end

			elseif (opt == "integration_vim_airline") then


				local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

				if (is_vim_airline_running == 0) then		-- is not running
					require("services.bottom.integrations.integration_vim_airline").enable_element()
				elseif (is_vim_airline_running == 1) then		-- is running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_vim_powerline") then


				local is_vim_airline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

				if (is_vim_airline_running == 0) then		-- is not running
					require("services.bottom.integrations.integration_vim_powerline").enable_element()
				elseif (is_vim_airline_running == 1) then		-- is running
					-- nothing
				else
					-- nothing either
				end

			-- under dev
			-- elseif (opt == "integration_lualine") then
			-- 	require("services.bottom.integrations.integration_vim_lualine").disable_element()
			elseif (opt == "integration_express_line") then

				require("services.bottom.integrations.integration_express_line").enable_element()

			elseif (opt == "integration_limelight") then

				require("services.bottom.integrations.integration_limelight").disable_element()

			else
				-- integration not recognized
			end
		else
			-- ignore it
		end
	end
end

function ataraxis_false()		-- hide


	local amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins > 1) then
		cmd("echo 'TZAtaraxis can not be toggled if there is more than one window open.'")
		goto there_was_more_tan_one_window
	else
		-- nothing
	end


	for opt, _ in pairs(opts["integrations"]) do
		if (opts["integrations"][opt] == true) then
			if (opt == "integration_galaxyline") then

				require("services.bottom.integrations.integration_galaxyline").disable_element()

			elseif (opt == "integration_gitgutter") then

				local is_gitgutter_running = vim.api.nvim_eval("get(g:, 'gitgutter_enabled', 0)")

				if (is_gitgutter_running == 1) then		-- is running
					require("services.bottom.integrations.integration_gitgutter").disable_element()
				elseif (is_gitgutter_running == 0) then		-- is not running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_vim_signify") then

				local is_vim_signify_running = vim.api.nvim_eval("empty(getbufvar(bufnr(''), 'sy'))")

				if (is_vim_signify_running == 1) then		-- is running
					require("services.bottom.integrations.integration_vim_signify").disable_element()
				elseif (is_vim_signify_running == 0) then		-- is not running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_tmux") then

				local is_tmux_running = vim.api.nvim_eval("$TMUX")

				if (is_tmux_running ~= "") then
					require("services.bottom.integrations.integration_tmux").disable_element()
				else
					-- tmux wasn't running
				end


			elseif (opt == "integration_vim_airline") then

				local is_vim_airline_running = vim.api.nvim_eval("exists('#airline')")

				if (is_vim_airline_running == 1) then		-- is running
					require("services.bottom.integrations.integration_vim_airline").disable_element()
				elseif (is_vim_airline_running == 0) then		-- is not running
					-- nothing
				else
					-- nothing either
				end


			elseif (opt == "integration_vim_powerline") then

				local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

				if (is_vim_powerline_running == 1) then		-- is running
					require("services.bottom.integrations.integration_vim_powerline").disable_element()
				elseif (is_vim_powerline_running == 0) then		-- is not running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_express_line") then

				require("services.bottom.integrations.integration_express_line").disable_element()

			elseif (opt == "integration_limelight") then

				require("services.bottom.integrations.integration_limelight").enable_element()

			else
				-- integration not recognized
			end
		else
			-- ignore it
		end
	end


	-- padding
	local left_padding_cmd = "vertical resize "..opts["ataraxis"]["left_padding"]..""

	-- left buffer
	cmd("leftabove vnew")
	cmd(left_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()

	-- return to middle buffer
	cmd("wincmd l")

	-- right buffer
	local right_padding_cmd = "vertical resize "..opts["ataraxis"]["right_padding"]..""
	cmd("vnew")
	cmd(right_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()



	-- return to middle buffer
	cmd("wincmd h")

	
	if (opts["ataraxis"]["top_padding"] > 0) then
		local top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
		cmd("leftabove new")
		cmd(top_padding_cmd)
		cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
		fillchars()

		-- return to middle buffer
		cmd("wincmd j")
	elseif (opts["ataraxis"]["top_padding"] == 0) then
		-- do nothing
	else
		cmd("echo 'invalid option set for top_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
	end

	if (opts["ataraxis"]["bottom_padding"] > 0) then
		local bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
		cmd("rightbelow new")
		cmd(bottom_padding_cmd)
		cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
		fillchars()

		-- return to middle buffer
		cmd("wincmd k")
	elseif (opts["ataraxis"]["bottom_padding"] == 0) then
		-- do nothing
	else
		cmd("echo 'invalid option set for bottom_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
	end


	fillchars()
	mode_minimalist.main(2)

	-- remove the border lines on every buffer
	cmd([[call BufDo("set fillchars+=vert:\\ ")]])

	-- hide whatever the user set to be hidden on the left hand side of vim
	cmd([[call BufDo("lua require'services.left.init'.main(2)")]])

	-- hide statusline color
	cmd("highlight StatusLine ctermfg=bg ctermbg=bg guibg=bg guifg=bg")

	-- hide horizontal fillchars' colors
	cmd("highlight StatusLineNC ctermfg=bg ctermbg=bg guibg=bg guifg=bg")

	-- doens't work
	-- require('galaxyline').disable_galaxyline()

	-- try to disable statuline regardless of which one is it
	cmd("setlocal statusline=-")


	-- everything will be skipped if there was more than one window open
	::there_was_more_tan_one_window::

	-- leaves you in another place
	-- cmd([[bufdo set fillchars+=vert:\ ]])
end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
