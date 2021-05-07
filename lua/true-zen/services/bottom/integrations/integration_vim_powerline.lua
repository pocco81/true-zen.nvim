local M = {}



local cmd = vim.cmd



function M.enable_element()
	cmd("doautocmd PowerlineStartup VimEnter")
	cmd("silent! PowerlineReloadColorscheme")
end

function M.disable_element()
	cmd("augroup PowerlineMain")
	cmd("autocmd!")
	cmd("augroup END")
	cmd("augroup! PowerlineMain")
end



return M
