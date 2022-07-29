local M = {}

local cmd = vim.cmd
local capture = vim.api.nvim_command_output
local status

local function is_status_on()
	if string.find(capture("!tmux show-option -w status"), "status on") then
		return true
	elseif string.find(capture("!tmux show-option -w status"), "status") == nil and string.find(capture("!tmux show-option -g status"), "status on") then
			return true
	end
end

function M.on()
	if vim.fn.exists('$TMUX') == 0 then
		return
	end

	if is_status_on() then
		cmd("silent !tmux set status off")
		status = true
	end
end

function M.off()
	if status == true then
		cmd("silent !tmux set status on")
	end
	status = nil
end

return M
