

local cmd = vim.cmd

-- bottom specific options
-- set noshowmode
-- set noruler
-- set laststatus=0
-- set noshowcmd
-- set cmdheight=1

function bottom_true()		-- show
	-- turn status line on
	-- this is for tabs: showtabline=2
	-- cmd("setlocal laststatus=2 showtabline=2")
	cmd("setlocal laststatus=2")
	cmd("setlocal ruler")
	-- cmd("setlocal showmode")
	-- cmd("setlocal showcmd")
	cmd("setlocal cmdheight=1")
end

function bottom_false()		-- don't show
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
	bottom_true = bottom_true,
	bottom_false = bottom_false
}

