


local cmd = vim.cmd

function statusline_true()		-- show
	-- turn status line on
	cmd("setlocal laststatus=2 showtabline=2")
	cmd("setlocal noruler")
end

function statusline_false()		-- don't show
	-- turn status line off
	cmd("setlocal laststatus=0 showtabline=0")
end



return {
	statusline_true = statusline_true,
	statusline_false = statusline_false
}
