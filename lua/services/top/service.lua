

local cmd = vim.cmd

-- top specific options
-- set showtabline=<num>

function top_true()		-- show
	cmd("setlocal showtabline=2")
end

function top_false()		-- don't show
	cmd("setlocal showtabline=0")
end



return {
	top_true = top_true,
	top_false = top_false
}

