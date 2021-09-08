local cmd = vim.cmd
local b = vim.b
local fn = vim.fn

local M = {}

function M.on(focus_type)
	if focus_type == "experimental" then
		b.truezen_mode_focus_buffer_view = fn.winsaveview()
		cmd("tabe %")
		fn.winrestview(b.truezen_mode_focus_buffer_view)
		cmd("unlet b:truezen_mode_focus_buffer_view")
	elseif focus_type == "native" then
		cmd("vert resize | resize")
		cmd("normal! ze")
	end
end

function M.off(focus_type)
	if focus_type == "experimental" then
		b.truezen_mode_focus_buffer_view = fn.winsaveview()
		cmd("q")
		fn.winrestview(b.truezen_mode_focus_buffer_view)
		cmd("unlet b:truezen_mode_focus_buffer_view")
	elseif focus_type == "native" then
		cmd("wincmd =")
		cmd("normal! ze")
	end
end

return M
