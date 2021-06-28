local service = require("true-zen.services.ui.left.service")
local cmd = vim.cmd
local api = vim.api

local opts = require("true-zen.config").options
local usp = require("true-zen.utils.ui_settings_applier")

local M = {}

local function get_status()
    return left_status
end

local function set_status(value)
    left_status = value
end

local function autocmds(state)
    if (state == "start") then
        api.nvim_exec(
            [[
			augroup truezen_ui_left
				autocmd!
				autocmd VimResume,FocusGained,WinEnter,BufWinEnter * if (&modifiable == 1) | execute "lua require'true-zen.services.ui.left'.resume()" | endif
			augroup END
		]],
            false
        )
    elseif (state == "stop") then
        api.nvim_exec([[
			augroup truezen_ui_left
				autocmd!
			augroup END
		]], false)
    end
end

local function on()
    autocmds("stop")
    cmd([[call g:TrueZenBufDo("lua require'true-zen.services.ui.left.service'.on()")]])
    set_status("on")
end

local function off()
    usp.save_local_settings(opts["ui"]["left"], "LEFT")
    cmd([[call g:TrueZenBufDo("lua require'true-zen.services.ui.left.service'.off()")]])
    autocmds("start")
    set_status("off")
end

function M.resume()
    service.off()
end

local function toggle()
    if (get_status() == "on") then
        off()
    elseif (get_status() == "off") then
        on()
    else
        if (api.nvim_eval("&number > 0 || &relativenumber > 0 || &signcolumn == 'yes'") == 1) then
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
