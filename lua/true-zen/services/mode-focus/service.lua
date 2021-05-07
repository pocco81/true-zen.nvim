local M = {}


local cmd = vim.cmd


-- bottom specific options

function M.native_focus_true()		-- show

	cmd("vert resize | resize")
	cmd("normal! ze")

end

function M.native_focus_false()		-- don't show
	
	cmd("wincmd =")
	cmd("normal! ze")

end

function M.experimental_focus_true()

	cmd("tabe %")
	
end

function M.experimental_focus_false()

	cmd("q")
	
end




return M

