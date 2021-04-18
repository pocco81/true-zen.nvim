

local cmd = vim.cmd

-- left specific options
-- set number
-- set relativenumber
-- set signcolumn=no

function left_true()		-- show
	cmd("setlocal number")
	-- cmd("setlocal relativenumber")
	-- cmd("setlocal signcolumn=yes")
end

function left_false()		-- don't show
	cmd("setlocal nonumber")
	cmd("setlocal norelativenumber")
	cmd("setlocal signcolumn=no")
end



return {
	left_true = left_true,
	left_false = left_false
}
