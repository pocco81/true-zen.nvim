local opts = require("true-zen.config").options
local mode_minimalist = require("true-zen.services.modes.mode-minimalist.init")
local hi_group = require("true-zen.services.modes.mode-ataraxis.modules.hi_group")
local fillchar = require("true-zen.services.modes.mode-ataraxis.modules.fillchar")
local integrations_loader = require("true-zen.services.integrations.modules.integrations_loader")
local special_integrations_loader = require("true-zen.services.integrations.modules.special_integrations_loader")
local colors = require("true-zen.utils.colors")

local cmd = vim.cmd
local api = vim.api
local o = vim.o
local fn = vim.fn

local iwaw_proportion
local truezen_layout
local splitbelow
local splitright
local hidden
local x_axis
local y_axis
local winhl
local normal_bg

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

local function set_winhl(val)
    winhl = val
end

local function get_winhl()
    return winhl
end

local function set_iwaw_proportion(val)
    iwaw_proportion = val
end

local function get_iwaw_proportion()
    return iwaw_proportion
end

local function set_normal_bg(color)
    normal_bg = color
end

local function get_normal_bg()
    return normal_bg
end

local function set_split(split, val)
    if (split == "splitbelow") then
        splitbelow = val
    else
        splitright = val
    end
end

local function get_split(split)
    if (split == "splitbelow") then
        return splitbelow
    else
        return splitright
    end
end

local function get_hidden()
    return hidden
end

local function set_hidden(val)
    hidden = val
end

local function ensure_settings()
    if (o.splitbelow == false) then
        set_split("splitbelow", false)
        o.splitbelow = true
    else
        set_split("splitbelow", true)
    end

    if (o.splitright == false) then
        set_split("splitright", false)
        o.splitright = true
    else
        set_split("splitright", true)
    end

    if (o.hidden == false) then
        set_hidden(false)
        o.hidden = true
    else
        set_hidden(true)
    end
end

local function restore_settings()
    o.splitbelow = get_split("splitbelow") or true
    o.splitright = get_split("splitright") or true
    o.hidden = get_hidden() or true
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

local function gen_background()
    local style = opts["modes"]["ataraxis"]["custom_bg"][1]
    local bg_prop = opts["modes"]["ataraxis"]["custom_bg"][2]

    if (style == "darken") then
        local normal = colors.get_hl("Normal")

        if normal and normal.background then
            local bg = colors.darken(normal.background, bg_prop)
            set_normal_bg({normal.background, bg}) -- [1] = user bg; [2] = truezen bg
            cmd(("highlight TrueZenBg guibg=%s guifg=%s"):format(bg, bg))
            cmd(("highlight TrueZenAuxBg guibg=%s"):format(bg))
            set_winhl("winhighlight=Normal:TrueZenBg")
        end
    elseif (style == "solid") then
        local normal = colors.get_hl("Normal")
        set_normal_bg({normal.background, bg_prop}) -- [1] = user bg; [2] = truezen bg
        cmd(("highlight TrueZenBg guibg=%s guifg=%s"):format(bg_prop, bg_prop))
        cmd(("highlight TrueZenAuxBg guibg=%s"):format(bg_prop))
        set_winhl("winhighlight=Normal:TrueZenBg")
    else
        set_winhl("")
    end
end

local function gen_window_specs(gen_command, command, extra)
    cmd(gen_command)
    cmd(command)
    cmd(
        [[
        setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0 ]] ..
            get_winhl() .. [[ | let w:truezen_window = 'true']]
    )

    if (extra ~= nil) then
        cmd(extra)
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

                if (#opts["modes"]["ataraxis"]["ideal_writing_area_width"] >= 2) then
                    local min = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
                    local max = opts["modes"]["ataraxis"]["ideal_writing_area_width"][2]
                    local pick = opts["modes"]["ataraxis"]["ideal_writing_area_width"][3]
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
                        if (pick == nil) then
                            ideal_writing_area_width = math.floor(unasserted_iwaw + 0.5)
                        else
                            if (pick == "max") then
                                ideal_writing_area_width = max
                            elseif (pick == "min") then
                                ideal_writing_area_width = min
                            end
                        end
                    end
                else
                    ideal_writing_area_width = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
                end

                local window_width = api.nvim_list_uis()[1]["width"]

                if (ideal_writing_area_width >= window_width) then
                    ideal_writing_area_width = window_width - 1
                end

                local total_left_right_width = window_width - ideal_writing_area_width

                if (total_left_right_width % 2 > 0) then
                    total_left_right_width = total_left_right_width + 1
                end

                local calculated_left_padding = total_left_right_width / 2
                local calculated_right_padding = total_left_right_width / 2

                left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
                right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
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

        gen_window_specs("leftabove vnew", left_padding_cmd, "wincmd l") -- left buffer
        gen_window_specs("vnew", right_padding_cmd, "wincmd h") -- right buffer
        gen_window_specs("leftabove new", top_padding_cmd, "wincmd j") -- top buffer
        gen_window_specs("rightbelow new", bottom_padding_cmd, "wincmd k") -- bottom buffer
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

local function tranq_normal_bg()
    local style = opts["modes"]["ataraxis"]["custom_bg"][1]
    if (style == "darken") then
        cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
    elseif (style == "solid") then
        cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
    end
end

local function restore_normal_bg()
    local style = opts["modes"]["ataraxis"]["custom_bg"][1]
    if (style == "darken") then
        cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
    elseif (style == "solid") then
        cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
    end
end

function M.on()
    local cursor_pos = fn.getpos(".")

    special_integrations_loader.unload_integrations()
    cmd("tabe %")
    if (mode_minimalist.get_status() == "off" or mode_minimalist.get_status() == nil) then
        mode_minimalist.main("on")
    end

    if (opts["modes"]["ataraxis"]["bg_configuration"] == true) then
        if (get_winhl() == nil) then
            gen_background()
        end

        tranq_normal_bg()
    end

    M.layout("generate")
    fillchar.store_fillchars()
    fillchar.set_fillchars()

    if (opts["modes"]["ataraxis"]["bg_configuration"] == true) then
        hi_group.store_hi_groups(opts["modes"]["ataraxis"]["affected_higroups"])

        local bg_color = opts["modes"]["ataraxis"]["custom_bg"][2]
        if (opts["modes"]["ataraxis"]["custom_bg"][1] == "darken") then
            bg_color = ""
        end

        hi_group.set_hi_groups(bg_color or "", opts["modes"]["ataraxis"]["affected_higroups"])

		cmd([[setlocal winhighlight=Normal:]] .. get_normal_bg()[1])
    end

    integrations_loader.unload_integrations()

    if
        (integrations_loader.get_has_line_with_integration() == nil or
            integrations_loader.get_has_line_with_integration() == false)
     then
        cmd([[setlocal statusline=-]])
    end

    fn.setpos(".", cursor_pos)
end

function M.off()
    local cursor_pos

    if (api.nvim_eval([[get(g:,"truezen_main_window", "no")]]) == fn.win_getid()) then
        cursor_pos = fn.getpos(".")
    end

    M.layout("destroy")
    mode_minimalist.main("off")
    integrations_loader.load_integrations()
    special_integrations_loader.load_integrations()
    fillchar.restore_fillchars()

    if (opts["modes"]["ataraxis"]["bg_configuration"] == true) then
        hi_group.restore_hi_groups()
		restore_normal_bg()
    end

    restore_settings()

    if (cursor_pos ~= nil) then
        fn.setpos(".", cursor_pos)
        cursor_pos = nil
    end
end

return M
