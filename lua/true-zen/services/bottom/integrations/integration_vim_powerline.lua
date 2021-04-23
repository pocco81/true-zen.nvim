



local cmd = vim.cmd



function enable_element()
	cmd("doautocmd PowerlineStartup VimEnter")
	cmd("silent! PowerlineReloadColorscheme")
end

function disable_element()
	cmd("augroup PowerlineMain")
	cmd("autocmd!")
	cmd("augroup END")
	cmd("augroup! PowerlineMain")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
