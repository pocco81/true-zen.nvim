

local cmd = vim.cmd



function enable_element()
	cmd("silent !tmux set -g status on")
end

function disable_element()
	cmd("silent !tmux set -g status off")
end



return {
	enable_element = enable_element,
	disable_element = disable_element
}
