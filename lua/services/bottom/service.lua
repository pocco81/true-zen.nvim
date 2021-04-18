

local cmd = vim.cmd

-- statusline specific options
-- set noshowmode
-- set noruler
-- set laststatus=0
-- set noshowcmd
-- set cmdheight=1

function statusline_true()		-- show
	-- turn status line on
	-- this is for tabs: showtabline=2
	-- cmd("setlocal laststatus=2 showtabline=2")
	cmd("setlocal laststatus=2")
	cmd("setlocal ruler")
	-- cmd("setlocal showmode")
	-- cmd("setlocal showcmd")
	cmd("setlocal cmdheight=1")
end

function statusline_false()		-- don't show
	-- turn status line off
	-- tabline is for the buffers
	-- laststatus is for the statusline
	cmd("setlocal laststatus=0")
	cmd("setlocal noruler")
	cmd("setlocal noshowmode")
	cmd("setlocal noshowcmd")
	cmd("setlocal cmdheight=1")
end



return {
	statusline_true = statusline_true,
	statusline_false = statusline_false
}

