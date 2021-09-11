local service = require("true-zen.services.modes.mode-ataraxis.service")
local opts = require("true-zen.config").options
local truezen = require("true-zen")

local api = vim.api
local cmd = vim.cmd
local status_mode_ataraxis

local M = {}

local function get_status()
	return status_mode_ataraxis
end

local function set_status(value)
	status_mode_ataraxis = value
end

local function redefine_ui_au()
	-- stylua: ignore
	api.nvim_exec([[
		augroup truezen_ui_left_resume
			autocmd!
			autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1 && exists("w:truezen_window")) | execute "lua require'true-zen.services.ui.left'.resume()" | endif
		augroup END
	]], false)
end

local function autocmds(state)
	if state == "start" then
		if not opts["modes"]["ataraxis"]["ignore_floating_windows"] then
			-- stylua: ignore
			api.nvim_exec([[
				augroup truezen_mode_ataraxis_resume_enter
					autocmd!
					autocmd WinEnter * if exists("w:truezen_window") | execute "lua require'true-zen.services.modes.mode-ataraxis.init'.resume()" | endif
				augroup END
			]], false)
		else
			-- stylua: ignore
			api.nvim_exec([[
				augroup truezen_mode_ataraxis_resume_enter
					autocmd!
					autocmd WinEnter * if exists("w:truezen_window") | if (g:truezen_last_floats == 1) | execute "lua require'true-zen.services.modes.mode-ataraxis.init'.resume()" | endif | endif
				augroup END
			]], false)

			-- stylua: ignore
			api.nvim_exec([[
				augroup truezen_mode_ataraxis_resume_leave
					autocmd!
					autocmd WinLeave * let g:truezen_last_floats = nvim_win_get_config(0).relative == ''
				augroup END
			]], false)
		end

		local quit_opt = opts["modes"]["ataraxis"]["quit"]
		if quit_opt ~= nil then
			if quit_opt == "untoggle" then
				-- stylua: ignore
				api.nvim_exec([[
					augroup truezen_mode_ataraxis_quit
						autocmd!
						autocmd QuitPre * execute "lua require'true-zen.services.modes.mode-ataraxis.init'.off()"
					augroup END
				]], false)
			elseif quit_opt == "close" then
				-- stylua: ignore
				api.nvim_exec([[
					augroup truezen_mode_ataraxis_quit
						autocmd!
						autocmd QuitPre * execute "lua require'true-zen.services.modes.mode-ataraxis.init'.off()" | quit
					augroup END
				]], false)
			end
		end

		redefine_ui_au()
	elseif state == "stop" then
		-- stylua: ignore
		api.nvim_exec([[
			augroup truezen_mode_ataraxis_resume_enter
				autocmd!
			augroup END
		]], false)

		if opts["modes"]["ataraxis"]["ignore_floating_windows"] then
			-- stylua: ignore
			api.nvim_exec([[
				augroup truezen_mode_ataraxis_resume_leave
					autocmd!
				augroup END
			]], false)
		end

		if opts["modes"]["ataraxis"]["quit"] ~= nil then
			-- stylua: ignore
			api.nvim_exec([[
				augroup truezen_mode_ataraxis_quit
					autocmd!
				augroup END
			]], false)
		end
	end
end

function M.on()
	if truezen.before_mode_ataraxis_on ~= nil then
		truezen.before_mode_ataraxis_on()
	end

	service.on()
	autocmds("start")
	set_status("on")

	if truezen.after_mode_ataraxis_on ~= nil then
		truezen.after_mode_ataraxis_on()
	end
end

function M.off()
	if truezen.before_mode_ataraxis_off ~= nil then
		truezen.before_mode_ataraxis_off()
	end

	autocmds("stop")
	service.off()
	set_status("off")

	if truezen.after_mode_ataraxis_off ~= nil then
		truezen.after_mode_ataraxis_off()
	end
end

function M.resume()
	if service.get_layout() ~= api.nvim_eval("winrestcmd()") then
		autocmds("stop")

		cmd([[call g:TrueZenWinDo("if !exists('w:truezen_window') | :q | endif")]])
		cmd(service.get_layout())
		cmd([[call win_gotoid(g:truezen_main_window)]])

		autocmds("start")
	end
end

local function toggle()
	if get_status() == "on" then
		M.off()
	else
		M.on()
	end
end

function M.main(option)
	option = option or 0

	if option == "toggle" then
		toggle()
	elseif option == "on" then
		if get_status() == "off" then
			M.on()
		else
			print("TrueZen: cannot turn ataraxis mode on because it is already on")
		end
	elseif option == "off" then
		if get_status() == "on" then
			M.off()
		else
			print("TrueZen: cannot turn ataraxis mode off because it is already off")
		end
	end
end

return M
