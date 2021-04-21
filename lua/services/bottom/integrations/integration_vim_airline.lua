


local cmd = vim.cmd



function enable_element()
	cmd("AirlineToggle")
end

function disable_element()
	cmd("AirlineToggle")
	cmd("silent! AirlineRefresh")
    cmd("silent! AirlineRefresh")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
