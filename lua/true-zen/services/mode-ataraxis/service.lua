

local opts = require("true-zen.config").options
local left_service = require("true-zen.services.left.service")
local mode_minimalist = require("true-zen.services.mode-minimalist.init")


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
	cmd([[set fillchars+=eob:\ ]])
end

function ataraxis_true()		-- show

	local amount_wins = vim.api.nvim_eval("winnr('$')")

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
			-- nothing
		end

		mode_minimalist.main(1)
		cmd("set fillchars=")

		-- if removed, it's likely that numberline and bottom will be removed
		cmd([[call BufDo("lua require'true-zen.services.left.init'.main(1)")]])
	end


	for opt, _ in pairs(opts["integrations"]) do
		if (opts["integrations"][opt] == true) then
			if (opt == "integration_galaxyline") then
				require("true-zen.services.bottom.integrations.integration_galaxyline").enable_element()
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

			elseif (opt == "integration_vim_powerline") then


				local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

				if (is_vim_powerline_running == 0) then		-- is not running
					require("true-zen.services.bottom.integrations.integration_vim_powerline").enable_element()
				elseif (is_vim_powerline_running == 1) then		-- is running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_express_line") then

				require("true-zen.services.bottom.integrations.integration_express_line").enable_element()

			elseif (opt == "integration_limelight") then

				require("true-zen.services.bottom.integrations.integration_limelight").disable_element()

			else
				-- integration not recognized
			end
		else
			-- ignore it
		end
	end
		
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

end


local function save_hi_groups()

	vim.api.nvim_exec([[
		function! ReturnHighlightTerm(group, term)
			" Store output of group to variable
			let output = execute('hi ' . a:group)

			" Find the term we're looking for
			return matchstr(output, a:term.'=\zs\S*')
		endfunction
	]], false)

	hi_groups = {
		NonText = {},
		FoldColumn = {},
		ColorColumn= {},
		VertSplit = {},
		StatusLine = {},
		StatusLineNC = {},
		SignColumn = {}
	}

	-- term != terminal; term = terminology
	terms = {
		'cterm',
		'ctermbg',
		'ctermfg',
		'guibg',
		'guifg',
		'gui'
	}


	for hi_index, _ in pairs(hi_groups) do

		for term_index, term_value in pairs(terms) do
			-- local to_call = "[[call ReturnHighlightTerm('"..hi_value.."', '"..term_value.."')]]"
			cmd("let term_val = ReturnHighlightTerm('"..hi_index.."', '"..term_value.."')")
			local term_val = vim.api.nvim_eval("g:term_val")
			-- cmd([[call BufDo("set fillchars+=vert:\\ ")]])
			cmd("echo 'Val = "..term_val.."'")
			table.insert(hi_groups, hi_index, term_val)
		end

	end

	hi_groups_stored = true

	if (hi_groups_stored == false or hi_groups_stored == nil) then

	elseif (hi_groups_stored == true) then
		cmd("echo '<Space>'")
		for hi_index, _ in pairs(hi_groups) do
			-- cmd("echo 'Index = "..tostring(hi_index).."; Value = "..tostring(hi_value).."'")
			for inner_hi_index, _ in pairs(hi_groups[hi_index]) do
				cmd("echo 'Index = "..tostring(inner_hi_index).."; Value = "..tostring(hi_groups[inner_hi_index]).."'")
			end
		end

	end
	
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


	for opt, _ in pairs(opts["integrations"]) do
		if (opts["integrations"][opt] == true) then
			if (opt == "integration_galaxyline") then

				require("true-zen.services.bottom.integrations.integration_galaxyline").disable_element()

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


			elseif (opt == "integration_vim_powerline") then

				local is_vim_powerline_running = vim.api.nvim_eval("exists('#PowerlineMain')")

				if (is_vim_powerline_running == 1) then		-- is running
					require("true-zen.services.bottom.integrations.integration_vim_powerline").disable_element()
				elseif (is_vim_powerline_running == 0) then		-- is not running
					-- nothing
				else
					-- nothing either
				end

			elseif (opt == "integration_express_line") then

				require("true-zen.services.bottom.integrations.integration_express_line").disable_element()

			elseif (opt == "integration_limelight") then

				require("true-zen.services.bottom.integrations.integration_limelight").enable_element()

			else
				-- integration not recognized
			end
		else
			-- ignore it
		end
	end


	local left_padding_cmd = ""
	local right_padding_cmd = ""

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



	-------------------- left buffer
	cmd("leftabove vnew")
	cmd(left_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()
	-------------------- left buffer




	-- return to middle buffer
	cmd("wincmd l")




	-------------------- right buffer
	cmd("vnew")
	cmd(right_padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()
	-------------------- right buffer



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
	cmd([[call BufDo("lua require'true-zen.services.left.init'.main(2)")]])


	if (opts["ataraxis"]["disable_bg_configuration"] == false) then
		
		if (opts["ataraxis"]["custome_bg"] == "" or opts["ataraxis"]["custome_bg"] == '' or opts["ataraxis"]["custome_bg"] == nil) then

			save_hi_groups()

			-- hide statusline color
			cmd("highlight StatusLine ctermfg=bg ctermbg=bg guibg=bg guifg=bg")
			-- hide horizontal fillchars' colors
			cmd("highlight StatusLineNC ctermfg=bg ctermbg=bg guibg=bg guifg=bg")
		else
			vim.api.nvim_exec([[
				function! GetColor(group, attr)
					return synIDattr(synIDtrans(hlID(a:group)), a:attr)
				endfunction
				com! -nargs=+ -complete=command GetColor call GetColor(<q-args>)

			]], false)

			vim.api.nvim_exec([[
				function! SetColor(group, attr, color)
					let gui = has('gui_running') || has('termguicolors') && &termguicolors
					execute printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
				endfunction
				com! -nargs=+ -complete=command SetColor call SetColor(<q-args>)
			]], false)

			vim.api.nvim_exec([[
				function! Tranquilize(bg_color)

					" make arg optional
					" let bg_color = get(a:, 1, 'black')
					let bg = GetColor('Normal', 'bg#')
					for grp in ['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit', 'StatusLine', 'StatusLineNC', 'SignColumn']
						" -1 on Vim / '' on GVim
						if bg == -1 || empty(bg)
							call SetColor(grp, 'fg', a:bg_color)
							call SetColor(grp, 'bg', 'NONE')
						else
							call SetColor(grp, 'fg', bg)
							call SetColor(grp, 'bg', bg)
						endif

						call SetColor(grp, '', 'NONE')
					endfor
				endfunction
			]], false)

			local custome_bg = opts["ataraxis"]["custome_bg"]
			local call_tran = "call Tranquilize('"..custome_bg.."')"
			cmd(call_tran)

		end
	elseif (opts["ataraxis"]["disable_bg_configuration"] == true) then
		-- do nothing
	else
		cmd("echo 'TrueZen: the disable_bg_configuration option was not set to a boolean'")
	end



	-- try to disable statuline regardless of which one is it
	cmd("setlocal statusline=-")



	-- under dev
	--[[
	if (opts["ataraxis"]["quit_untoggles_ataraxis"] == true) then

		vim.api.nvim_exec([[
			augroup ataraxisExit
				autocmd!
				"executes the command on quit
				autocmd BufWinLeave * execute "lua ataraxis_true()"

				" execute the command on write
				" autocmd BufWritePost,FileWritePost *.cpp !your_commad
			augroup END
		, false)

	else
		-- nothing
	end
	]]--


	-- everything will be skipped if there was more than one window open
	::there_was_more_than_one_window::

	-- leaves you in another place
	-- cmd([[bufdo set fillchars+=vert:\ ]])
end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
