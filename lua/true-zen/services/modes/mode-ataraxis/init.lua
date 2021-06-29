local service = require("true-zen.services.modes.mode-ataraxis.service")
-- local truezen = require("true-zen.init")

local api = vim.api
local fn = vim.fn
local cmd = vim.cmd

local M = {}

local function get_status()
    return status_mode_ataraxis
end

local function set_status(value)
    status_mode_ataraxis = value
end

local function eval_main_window()
	vim.cmd([[windo if &ma | if exists("b:truezen_main_window_id") | let g:truezen_main_window = b:truezen_main_window_id | endif | endif]])
end

local function autocmds(state)
    if (state == "start") then
        api.nvim_exec(
            [[
			augroup truezen_mode_ataraxis
				autocmd!
				autocmd VimResume,FocusGained,WinEnter,BufWinEnter * execute "lua require'true-zen.services.modes.mode-ataraxis.init'.resume()"
			augroup END
		]],
            false
        )
    elseif (state == "stop") then
        api.nvim_exec([[
			augroup truezen_mode_ataraxis
				autocmd!
			augroup END
		]], false)
    end
end

local function get_win_dimensions()
	local dimensions = {}
	dimensions["x_axis"] = api.nvim_eval([[winwidth('%')]])
	dimensions["y_axis"] = api.nvim_eval([[winheight('%')]])

	return dimensions
end

local function on()
    service.on()
	autocmds("start")
    set_status("on")
end

local function off()
	autocmds("stop")
    service.off()
    set_status("off")
end

function M.resume()
	local window_id = api.nvim_eval([[get(g:,"truezen_main_window_id", 1000)]])
	print("window id = "..window_id)
	fn.win_gotoid(window_id)

	-- print("TZ buff"..tostring(fn.exists("b:truezen_buffer")))
	-- if (fn.exists("b:truezen_buffer") == 1) then
	-- 	eval_main_window()
	-- 	print(tostring(vim.g.truezen_main_window))
	-- else
	-- 	print("it was not a padding buffer")
	-- end
	-- local window_id = api.nvim_eval([[get(g:,"truezen_main_window", "NONE")]])

	-- if not (window_id == "NONE") then
	-- 	fn.win_gotoid(window_id)
	-- 	cmd([[unlet g:truezen_main_window]])

	-- 	local dimensions = get_win_dimensions()

	-- 	if (dimensions["x_axis"] ~= service.get_axis_length("x_axis") or dimensions["y_axis"] ~= service.get_axis_length("y_axis")) then
	-- 		cmd("only")
	-- 		service.layout("generate")
	-- 	end
	-- else
	-- 	print("TrueZen: an error occurred, main window was deleted.")
	-- end
end

local function toggle()
    if (get_status() == "on") then
        off()
    else
        on()
    end
end

function M.main(option)
    option = option or 0

    if (option == "toggle") then
        toggle()
    elseif (option == "on") then
        on()
    elseif (option == "off") then
        off()
    end
end

return M
