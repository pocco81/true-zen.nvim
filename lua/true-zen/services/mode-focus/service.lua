


local cmd = vim.cmd


-- bottom specific options

function focus_true()		-- show

	cmd("vert resize | resize")
	cmd("normal! ze")

end

function focus_false()		-- don't show
	
	cmd("wincmd =")
	cmd("normal! ze")

end



return {
	focus_true = focus_true,
	focus_false = focus_false
}

