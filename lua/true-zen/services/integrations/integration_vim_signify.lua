


local cmd = vim.cmd



function enable_element()
	cmd("SignifyToggle")
end

function disable_element()
	cmd("SignifyToggle")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
