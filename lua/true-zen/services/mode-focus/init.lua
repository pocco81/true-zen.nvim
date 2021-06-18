local service = require("true-zen.services.mode-focus.service")
local opts = require("true-zen.config").options
local true_zen = require("true-zen")

local cmd = vim.cmd
local api = vim.api

-- show and hide focus funcs
local function focus_true() -- focus window
    if (opts["events"]["before_focus_mode_focuses"] == true) then
        true_zen.before_focus_mode_focuses()
    end

    local focus_method = opts["focus"]["focus_method"]
    local amount_wins = vim.api.nvim_eval("winnr('$')")

    if (focus_method == "native" or focus_method == "Native") then
        if (amount_wins == 1) then
            cmd(
                "echo 'You can not focus this window because focusing a window only works when there are more than one.'"
            )
            focus_show = 0
        elseif (amount_wins > 1) then
            focus_show = 1
            service.native_focus_true()
        end
    elseif (focus_method == "experimental" or focus_method == "Experimental") then
        focus_show = 1
        service.experimental_focus_true()

        if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
            -- nil if it hasn't been toggled
            ataraxis_is_toggled = require("true-zen.services.mode-ataraxis.init").ataraxis_show
            if (ataraxis_is_toggled == 0 or ataraxis_is_toggled == nil) then
                require "true-zen.main".main(4, 2)
                ataraxis_is_toggled = 1
            end
        end
    end
	vim.g.__truezen_focus_loaded = "true"

    if (opts["events"]["after_focus_mode_focuses"] == true) then
        true_zen.after_focus_mode_focuses()
    end
end

local function focus_false() -- unfocus window
    if (opts["events"]["before_focus_mode_unfocuses"] == true) then
        true_zen.before_focus_mode_unfocuses()
    end

    local focus_method = opts["focus"]["focus_method"]
    local amount_wins = vim.api.nvim_eval("winnr('$')")

    if (focus_method == "native" or focus_method == "Native") then
        focus_show = 0

        if (amount_wins == 1) then
            cmd(
                "echo 'You can not unfocus this window because focusing a window only works when there are more than one.'"
            )
        elseif (amount_wins > 1) then
            service.native_focus_false()
        end
    elseif (focus_method == "experimental" or focus_method == "Experimental") then
        focus_show = 0

        -- if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
        --     -- if it's nil or anything else then it's because it hasn't been executed
        --     if (ataraxis_is_toggled == 1) then
        --         require "true-zen.main".main(4, 1)
        --     end
        -- end

        service.experimental_focus_false()
    end

	vim.g.__truezen_focus_loaded = "false"

    if (opts["events"]["after_focus_mode_unfocuses"] == true) then
        true_zen.after_focus_mode_unfocuses()
    end
end

-- 1 = is focused
-- 0 = is not focused
local function toggle()
    if (focus_show ~= nil and focus_show == 1) then
        focus_false()
    elseif (focus_show ~= nil and focus_show == 0) then
        focus_true()
    elseif (focus_show == nil) then
        local amount_wins = vim.api.nvim_eval("winnr('$')")

        if (amount_wins > 1) then
            local focus_method = opts["focus"]["focus_method"]

            if (focus_method == "native" or focus_method == "Native") then
                local current_session_height = vim.api.nvim_eval("&co")
                local current_session_width = vim.api.nvim_eval("&lines")
                local total_current_session = tonumber(current_session_width) + tonumber(current_session_height)

                local current_window_height = vim.api.nvim_eval("winheight('%')")
                local current_window_width = vim.api.nvim_eval("winwidth('%')")
                local total_current_window = tonumber(current_window_width) + tonumber(current_window_height)

                difference = total_current_session - total_current_window

                for i = 1, tonumber(opts["focus"]["margin_of_error"]), 1 do
                    if (difference == i) then
                        -- since difference is small, it's assumable that window is focused
                        focus_false()
                        break
                    elseif (i == tonumber(opts["focus"]["margin_of_error"])) then
                        -- difference is too big, it's assumable that window is not focused
                        focus_true()
                        break
                    else
                        -- nothing
                    end
                end
            elseif (focus_method == "experimental" or focus_method == "Experimental") then
                -- orig_win_id = vim.api.nvim_eval("win_getid()")
                focus_true()
            end
        else
            -- since there should always be at least one window
            focus_show = 0
            cmd("echo 'you can not (un)focus this window, because it is the only one!'")
        end
    end
end

function main(option)
    option = option or 0

    if (option == 0) then -- toggle focus (on/off)
        toggle()
    elseif (option == 1) then -- focus window
        focus_true()
    elseif (option == 2) then -- unfocus window
        focus_false()
    else
        -- not recognized
    end
end

return {
    main = main
}
