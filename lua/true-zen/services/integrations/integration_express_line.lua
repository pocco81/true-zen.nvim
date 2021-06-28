


local api = vim.api



function enable_element()
	require('el').setup()
end

function disable_element()
	-- nothing
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
