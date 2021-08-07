local service = require("true-zen.services.modes.mode-focus.service")
local opts = require("true-zen.config").options
local truezen = require("true-zen")

local api = vim.api
local cmd = vim.cmd

local M = {}

local function get_status()
    return status_mode_focus
end

local function set_status(value)
    status_mode_focus = value
end

function M.on(focus_type)

    if (truezen.before_mode_focus_on ~= nil) then
        truezen.before_mode_focus_on()
    end

    service.on()

    if (api.nvim_eval("winnr('$')") > 1) then
        if (focus_type == "experimental") then
            service.on("experimental")
        elseif (focus_type == "native") then
            service.on("native")
        end
    else
        print("TrueZen: You cannot focus the current window because there is only one")
    end

    set_status("on")

    if (truezen.after_mode_focus_on ~= nil) then
        truezen.after_mode_focus_on()
    end
end

function M.off(focus_type)

    if (truezen.before_mode_focus_off ~= nil) then
        truezen.before_mode_focus_off()
    end

    service.off()

    if (focus_type == "experimental") then
        service.off("experimental")
    elseif (focus_type == "native") then
        service.off("native")
    end

    set_status("off")

    if (truezen.after_mode_focus_off ~= nil) then
        truezen.after_mode_focus_off()
    end
end

local function toggle()
    if (get_status() == "on") then
        M.off(opts["modes"]["focus"]["focus_method"])
    elseif (get_status() == "off") then
        M.on(opts["modes"]["focus"]["focus_method"])
    else
        if (api.nvim_eval("winnr('$')") > 1) then
            local focus_method = opts["modes"]["focus"]["focus_method"]

            if (focus_method == "native") then
                local current_session_height = api.nvim_eval("&co")
                local current_session_width = api.nvim_eval("&lines")
                local total_current_session = tonumber(current_session_width) + tonumber(current_session_height)

                local current_window_height = api.nvim_eval("winheight('%')")
                local current_window_width = api.nvim_eval("winwidth('%')")
                local total_current_window = tonumber(current_window_width) + tonumber(current_window_height)

                difference = total_current_session - total_current_window

                for i = 1, tonumber(opts["modes"]["focus"]["margin_of_error"]), 1 do
                    if (difference == i) then -- since difference is small, it's assumable that window is focused
                        M.off("native")
                        break
                    elseif (i == tonumber(opts["modes"]["focus"]["margin_of_error"])) then -- difference is too big, it's assumable that window is not focused
                        M.on("native")
                        break
                    end
                end
            elseif (focus_method == "experimental") then
                M.on("experimental")
            end
        else
            print("TrueZen: You cannot focus the current window because there is only one")
        end
    end
end

function M.main(option)
    option = option or 0

    if (option == "toggle") then
        toggle()
    elseif (option == "on") then
		if (get_status() == "off") then M.on() else print("TrueZen: cannot turn focus mode on because it is already on") end
    elseif (option == "off") then
		if (get_status() == "on") then M.off() else print("TrueZen: cannot turn focus mode off because it is already off") end
    end
end

return M
