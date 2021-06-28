local service = require("true-zen.services.ui.top.service")
local cmd = vim.cmd
local api = vim.api

local usp = require("true-zen.utils.ui_settings_applier")
local opts = require("true-zen.config").options

local M = {}

local function get_status()
    return status_top
end

local function set_status(value)
    status_top = value
end

local function autocmds(state)
    if (state == "start") then
        api.nvim_exec(
            [[
			augroup truezen_ui_top
				autocmd!
				autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.ui.top'.resume()" | endif
			augroup END
		]],
            false
        )
    elseif (state == "stop") then
        api.nvim_exec([[
			augroup truezen_ui_top
				autocmd!
			augroup END
		]], false)
    end
end

local function on()
    autocmds("stop")
    service.on()
    set_status("on")
end

local function off()
    usp.save_local_settings(opts["ui"]["top"], "TOP")
    service.off()
    autocmds("start")
    set_status("off")
end

function M.resume()
    service.off()
    if (opts["integrations"]["nvim_bufferline"] == true) then
		nvim_bufferline()
    end
end

local function toggle()
    if (get_status() == "on") then
        off()
    elseif (get_status() == "off") then
        on()
    else
        if (api.nvim_eval("&showtabline > 0") == 1) then
            off()
        else
            on()
        end
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
