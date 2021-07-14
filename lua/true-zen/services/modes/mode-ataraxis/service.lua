local opts = require("true-zen.config").options
local mode_minimalist = require("true-zen.services.modes.mode-minimalist.init")
local hi_group = require("true-zen.services.modes.mode-ataraxis.modules.hi_group")
local fillchar = require("true-zen.services.modes.mode-ataraxis.modules.fillchar")
local integrations_loader = require("true-zen.services.integrations.modules.integrations_loader")
local special_integrations_loader = require("true-zen.services.integrations.modules.special_integrations_loader")

local cmd = vim.cmd
local api = vim.api

local iwaw_proportion

local M = {}

function M.get_axis_length(axis)
    if (axis == "x") then
        return x_axis
    end

    return y_axis
end

function M.set_layout(layout)
    truezen_layout = layout
end

function M.get_layout()
    return truezen_layout
end

function M.set_axis_length(axis, value)
    if (axis == "x") then
        x_axis = value
    else
        y_axis = value
    end
end

local function set_iwaw_proportion(val)
    iwaw_proportion = val
end

local function get_iwaw_proportion()
    return iwaw_proportion
end

-- local function set_min_iwaw()

-- end

-- local function get_min_iwaw()

-- end

local function ensure_settings()
    if (api.nvim_eval("&splitbelow != 0 || &splitright != 0") == 1) then
        cmd("set splitbelow")
        cmd("set splitright")
    end
end

local function unlet_padding_vars()
    api.nvim_exec(
        [[
		if exists("g:tz_top_padding") | unlet g:tz_top_padding | endif
		if exists("g:tz_bottom_padding") | unlet g:tz_bottom_padding | endif
		if exists("g:tz_left_padding") | unlet g:tz_left_padding | endif
		if exists("g:tz_right_padding") | unlet g:tz_right_padding | endif
	]],
        false
    )
end

local function gen_buffer_specs(gen_command, command, extra)
    cmd(gen_command)
    cmd(command)
    cmd(
        [[
        setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0 | let w:truezen_window = 'true']]
    )

    if (extra ~= nil) then
        cmd(extra)
    end
end

function window_has_neighbour(direction)
    local current_position = api.nvim_eval([[win_screenpos(winnr())]])
    local amount_windows = api.nvim_eval("winnr('$')")

    if (direction == "top") then
        return current_position[1] ~= 1
    elseif (direction == "bottom") then
        while (amount_windows > 0) do
            local position = api.nvim_eval([[win_screenpos(]] .. amount_windows .. [[)]])
            amount_windows = amount_windows - 1

            if ((current_position[1] + api.nvim_eval("winheight(0)")) < position[1]) then
                return true
            end
        end
        return false
    elseif (direction == "left") then
        return current_position[2] ~= 1
    elseif (direction == "right") then
        while (amount_windows > 0) do
            local position = api.nvim_eval([[win_screenpos(]] .. amount_windows .. [[)]])
            amount_windows = amount_windows - 1

            if ((current_position[2] + api.nvim_eval("winwidth(0)")) < position[2]) then
                return true
            end
        end
        return false
    end
end

function M.layout(action)
    if (action == "generate") then
        ensure_settings()

        tz_top_padding = api.nvim_eval([[get(g:,"tz_top_padding", "NONE")]])
        tz_left_padding = api.nvim_eval([[get(g:,"tz_left_padding", "NONE")]])
        tz_right_padding = api.nvim_eval([[get(g:,"tz_right_padding", "NONE")]])
        tz_bottom_padding = api.nvim_eval([[get(g:, "tz_bottom_padding", "NONE")]])

        local left_padding_cmd = ""
        local right_padding_cmd = ""
        local top_padding_cmd = ""
        local bottom_padding_cmd = ""

        if (tz_left_padding ~= "NONE" or tz_right_padding ~= "NONE") then
            if not (tz_left_padding == "NONE") then
                left_padding_cmd = "vertical resize " .. tz_left_padding .. ""
            else
                left_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["left_padding"] .. ""
            end

            if not (tz_right_padding == "NONE") then
                right_padding_cmd = "vertical resize " .. tz_right_padding .. ""
            else
                right_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["right_padding"] .. ""
            end
        else
            if (opts["modes"]["ataraxis"]["ideal_writing_area_width"][1] > 0) then
                local ideal_writing_area_width

                if (#opts["modes"]["ataraxis"]["ideal_writing_area_width"] == 2) then
                    local min = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
                    local max = opts["modes"]["ataraxis"]["ideal_writing_area_width"][2]
                    local diff = max - min

                    if (get_iwaw_proportion() == nil) then
                        set_iwaw_proportion(diff / api.nvim_list_uis()[1]["width"])
                    end

					local unasserted_iwaw = get_iwaw_proportion() * api.nvim_list_uis()[1]["width"]

					if (unasserted_iwaw > max) then
						ideal_writing_area_width = max
					elseif (unasserted_iwaw < min) then
						ideal_writing_area_width = min
					else
						ideal_writing_area_width = math.floor(unasserted_iwaw + 0.5)
						print("ideal_writing_area_width = " .. ideal_writing_area_width)
					end

                else
                    ideal_writing_area_width = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
                end

                local window_width = api.nvim_list_uis()[1]["width"]

                if (ideal_writing_area_width == window_width) then
                    print(
                        "TrueZen: the ideal_writing_area_width setting cannot have the same size as your current window, it must be smaller than " ..
                            window_width
                    )
                else
                    local total_left_right_width = window_width - ideal_writing_area_width

                    if (total_left_right_width % 2 > 0) then
                        total_left_right_width = total_left_right_width + 1
                    end

                    local calculated_left_padding = total_left_right_width / 2
                    local calculated_right_padding = total_left_right_width / 2

                    left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
                    right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
                end
            else
                if (opts["modes"]["ataraxis"]["just_do_it_for_me"] == true) then
                    local calculated_left_padding = api.nvim_eval("winwidth('%') / 4")
                    local calculated_right_padding = api.nvim_eval("winwidth('%') / 4")

                    left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
                    right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
                else
                    left_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["left_padding"] .. ""
                    right_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["right_padding"] .. ""
                end
            end
        end

        -- TODO: REPLACE THIS WITH PCALL TO AVOID NEGATIVE NUMBERS
        if not (tz_top_padding == "NONE") then
            top_padding_cmd = "resize " .. tz_top_padding .. ""
        else
            top_padding_cmd = "resize " .. opts["modes"]["ataraxis"]["top_padding"] .. ""
        end

        if not (tz_bottom_padding == "NONE") then
            bottom_padding_cmd = "resize " .. tz_bottom_padding .. ""
        else
            bottom_padding_cmd = "resize " .. opts["modes"]["ataraxis"]["bottom_padding"] .. ""
        end

        gen_buffer_specs("leftabove vnew", left_padding_cmd, "wincmd l") -- left buffer
        gen_buffer_specs("vnew", right_padding_cmd, "wincmd h") -- right buffer
        gen_buffer_specs("leftabove new", top_padding_cmd, "wincmd j") -- top buffer
        gen_buffer_specs("rightbelow new", bottom_padding_cmd, "wincmd k") -- bottom buffer
        -- final position: middle buffer

        if (M.get_axis_length("x") == nil) then
            M.set_axis_length("x", api.nvim_eval([[winwidth('%')]]))
            M.set_axis_length("y", api.nvim_eval([[winheight('%')]]))
        end

        cmd([[let g:truezen_main_window = win_getid()]])
        cmd([[let w:truezen_window = 'true']])
        M.set_layout(api.nvim_eval([[winrestcmd()]]))
    elseif (action == "destroy") then
        cmd("only")
        cmd("q")

        unlet_padding_vars()
    end
end

function M.on()
    -- for some reason if the integrations are loaded after `tabe %` some integrations stop working
    special_integrations_loader.unload_integrations()
    cmd("tabe %")
    mode_minimalist.main("on")
    M.layout("generate")
    fillchar.store_fillchars()
    fillchar.set_fillchars()

    if (opts["modes"]["ataraxis"]["bg_configuration"] == true) then
        hi_group.store_hi_groups(opts["modes"]["ataraxis"]["affected_higroups"])
        hi_group.set_hi_groups(opts["modes"]["ataraxis"]["custome_bg"], opts["modes"]["ataraxis"]["affected_higroups"])
    end

    integrations_loader.unload_integrations()

    if
        (integrations_loader.get_has_line_with_integration() == nil or
            integrations_loader.get_has_line_with_integration() == false)
     then
        cmd([[setlocal statusline=-]])
    end
end

function M.off()
    M.layout("destroy")
    mode_minimalist.main("off")
    integrations_loader.load_integrations()
    special_integrations_loader.load_integrations()
    fillchar.restore_fillchars()

    if (opts["modes"]["ataraxis"]["bg_configuration"] == true) then
        hi_group.restore_hi_groups()
    end
end

return M
