

local opts = require("config").options
local left_service = require("services.left.service")
local mode_minimalist = require("services.mode-minimalist.init")

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

local function fillchars()
	cmd([[set fillchars+=vert:\ ]])
	cmd([[set fillchars+=stl:\ ]])
	cmd([[set fillchars+=stlnc:\ ]])
end

function ataraxis_true()		-- show

	amount_wins = vim.api.nvim_eval("winnr('$')")

	if (amount_wins == 1) then
		cmd("echo 'Can not exit Ataraxi Mode because you are currently not in it'")
	elseif (amount_wins == 3) then
		cmd("wincmd h")
		cmd("q")
		cmd("wincmd l")
		cmd("q")
		mode_minimalist.main(1)
		cmd("set fillchars=")
		cmd([[call BufDo("lua require'services.left.init'.main(1)")]])
	end

end

function ataraxis_false()		-- don't show

	-- padding
	local padding_cmd = "vertical resize "..opts["ataraxis"]["left_right_padding"]..""

	-- left buffer
	cmd("leftabove vnew")
	cmd(padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()

	-- middle buffer
	cmd("wincmd l")

	-- right buffer
	cmd("vnew")
	cmd(padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()



	-- middle buffer
	cmd("wincmd h")
	fillchars()
	mode_minimalist.main(2)

	-- remove the border lines on every buffer
	cmd([[call BufDo("set fillchars+=vert:\\ ")]])

	-- hide whatever the user set to be hidden on the left hand side of vim
	cmd([[call BufDo("lua require'services.left.init'.main(2)")]])




	-- leaves you in another place
	-- cmd([[bufdo set fillchars+=vert:\ ]])
end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
