



local cmd = vim.cmd



function enable_element()
	cmd("Limelight")
end

function disable_element()
	cmd("Limelight!")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
