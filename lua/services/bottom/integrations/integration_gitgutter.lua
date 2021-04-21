


local cmd = vim.cmd



function enable_element()
	cmd("silent! GitGutterEnable")
end

function disable_element()
	cmd("silent! GitGutterDisable")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
