local opts = require("true-zen.config").options
local hi_group = require("true-zen.services.mode-ataraxis.modules.hi_group")
local fillchar = require("true-zen.services.mode-ataraxis.modules.fillchar")

local cmd = vim.cmd
local api = vim.api


function ataraxis_true() -- show
    local ataraxis_was_quitted = ""

    mode_minimalist.main(1)
	vim.g.__truezen_ataraxis_hiding = "false"

    if (opts["ataraxis"]["quit_untoggles_ataraxis"] == true) then
        vim.api.nvim_exec([[
			augroup exit_ataraxis_too
				autocmd!
			augroup END
		]], false)

        ataraxis_was_quitted = vim.api.nvim_eval([[get(g:,"ataraxis_was_quitted", "NONE")]])
    end

    if (ataraxis_was_quitted == "true") then
        cmd("unlet g:ataraxis_was_quitted")
        goto skip_normal_quitting
    end

    cmd("wincmd h")
    cmd("q")
    cmd("wincmd l")
    cmd("q")

    if (opts["ataraxis"]["top_padding"] > 0 or tz_top_padding ~= "NONE" and tonumber(tz_top_padding) > 0) then
        cmd("wincmd k")
        cmd("q")

        if (top_use_passed_params == true) then
            cmd("unlet g:tz_top_padding")
            top_use_passed_params = false
        end
    else
        -- nothing
    end

    if (opts["ataraxis"]["bottom_padding"] > 0 or tz_bottom_padding ~= "NONE" and tonumber(tz_bottom_padding) > 0) then
        cmd("wincmd j")
        cmd("q")

        if (bottom_use_passed_params == true) then
            cmd("unlet g:tz_bottom_padding")
            bottom_use_passed_params = false
        end
    else
        -- nothing
    end

    ::skip_normal_quitting::

    ------- general
    cmd("set fillchars=")

    -- if removed, it's likely that numberline and bottom will be removed
    -- cmd([[call BufDo("lua require'true-zen.services.left.init'.main(1)")]])
    ------ general

    --------------------------=== Splits stuff ===--------------------------
    -- return splitbelow and splitright to user settings:
    if (is_splitbelow_set == 1) then
        -- it's already set
        -- cmd("set splitbelow")
    elseif (is_splitbelow_set == 0) then
        cmd("set nosplitbelow")
    end

    if (is_splitright_set == 1) then
        -- it's already set
        -- cmd("set splitright")
    elseif (is_splitright_set == 0) then
        cmd("set nosplitright")
    end
    --------------------------=== Splits stuff ===--------------------------

    --------------------------=== Fill chars ===--------------------------

    if (opts["ataraxis"]["disable_fillchars_configuration"] == false) then
        fillchar.restore_fillchars()
    else
        -- nothing
    end

    --------------------------=== Fill chars ===--------------------------

    --------------------------=== Hi Groups ===--------------------------

    if (opts["ataraxis"]["disable_bg_configuration"] == false) then
        hi_group.restore_hi_groups()
    else
        -- nothing
    end

    --------------------------=== Hi Groups ===--------------------------

    if (has_statusline_with_integration == true) then
        -- ignore
    else
        cmd("setlocal statusline=" .. current_statusline .. "")
    end

    -------------------------=== Integrations ===------------------------
    vim.api.nvim_exec([[
		augroup false_integrations
			autocmd!
		augroup END
	]], false)

    load_integrations(true)

    vim.api.nvim_exec(
        [[
		augroup true_integrations
			autocmd!
			autocmd BufWinEnter * if (&modifiable == 1) | execute "lua load_integrations(true)" | endif
		augroup END
	]],
        false
    )
    -------------------------=== Integrations ===------------------------

	if (it_was_focused == true) then
		if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
			if not (opts["focus"]["focus_method"] == "experimental") then
				print("TrueZen: you need to set 'focus_method = experimental' in order to use the 'integration_tzfocus_tzataraxis' integration")
			else
				require("true-zen.services.mode-focus.init").main(2)
			end
		end
		it_was_focused = false
	end

end

function ataraxis_false() -- hide
    local amount_wins = vim.api.nvim_eval("winnr('$')")


    if (amount_wins > 1) then
		if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
			if not (opts["focus"]["focus_method"] == "experimental") then
				print("TrueZen: you need to set 'focus_method = experimental' in order to use the 'integration_tzfocus_tzataraxis' integration")
			else
				require("true-zen.services.mode-focus.init").main(1)
				it_was_focused = true
			end
        elseif (opts["ataraxis"]["force_when_plus_one_window"] == true) then
            cmd("only")
		else
			print("TrueZen: TZAtaraxis can not be toggled if there is more than one window open. However, you can force it with the force_when_plus_one_window setting")
        end
	end

-- 	if (opts["integrations"]["integration_tzfocus_tzataraxis"] == true) then
--
--     if (amount_wins > 1) then
-- 		require'true-zen.main'.main(5, 1)
-- 	end
--
-- 	end
--
--     if (amount_wins > 1) then
--         if (opts["ataraxis"]["force_when_plus_one_window"] == false) then
--             cmd(
--                 "echo 'TrueZen: TZAtaraxis can not be toggled if there is more than one window open. However, you can force it with the force_when_plus_one_window setting'"
--             )
--             goto there_was_more_than_one_window
--         elseif (opts["ataraxis"]["force_when_plus_one_window"] == true) then
--             cmd("only")
--         end
--     end

    mode_minimalist.main(2)
	vim.g.__truezen_ataraxis_hiding = "true"


    if (opts["ataraxis"]["quit_untoggles_ataraxis"] == true) then
        vim.api.nvim_exec(
            [[
			augroup exit_ataraxis_too
				autocmd!
				autocmd QuitPre * only | let g:the_id = win_getid() | tabe % | call win_gotoid(g:the_id) | close | let g:ataraxis_was_quitted = "true" | execute "lua require('true-zen.services.mode-ataraxis.init').main(0)"
			augroup END
		]],
            false
        )
    end

    -- autocmd QuitPre * only | let g:the_id = win_getid() | tabe % | call win_gotoid(g:the_id) | close | let g:ataraxis_was_quitted = "true" | execute "lua ataraxis_true()"

    ---------------- solves: Vim(Buffer): E86: Buffer 3 does not exist
    is_splitbelow_set = vim.api.nvim_eval("&splitbelow")
    is_splitright_set = vim.api.nvim_eval("&splitright")

    if (is_splitbelow_set == 0 or is_splitright_set == 0) then
        cmd("set splitbelow")
        cmd("set splitright")
    else
        -- continue
    end
    ---------------- solves: Vim(Buffer): E86: Buffer 3 does not exist

    -- mode_minimalist.main(2)

--     if (opts["minimalist"]["store_and_restore_settings"] == true) then
--         top_has_been_stored = before_after_cmds.get_has_been_stored("TOP")
--         bottom_has_been_stored = before_after_cmds.get_has_been_stored("BOTTOM")
--         left_has_been_stored = before_after_cmds.get_has_been_stored("LEFT")
--
--         if not (top_has_been_stored == true) then
--             before_after_cmds.store_settings(opts["top"], "TOP")
--         end
--
--         if not (bottom_has_been_stored == true) then
--             before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
--         end
--
--         if not (left_has_been_stored == true) then
--             before_after_cmds.store_settings(opts["left"], "LEFT")
--         end
--     end

    -------------------------=== Integrations ===------------------------
    vim.api.nvim_exec([[
		augroup true_integrations
			autocmd!
		augroup END
	]], false)

    load_integrations(false)
    -------------------------=== Integrations ===------------------------

    tz_top_padding = vim.api.nvim_eval([[get(g:,"tz_top_padding", "NONE")]])
    tz_left_padding = vim.api.nvim_eval([[get(g:,"tz_left_padding", "NONE")]])
    tz_right_padding = vim.api.nvim_eval([[get(g:,"tz_right_padding", "NONE")]])
    tz_bottom_padding = vim.api.nvim_eval([[get(g:, "tz_bottom_padding", "NONE")]])

    local left_padding_cmd = ""
    local right_padding_cmd = ""
    local top_padding_cmd = ""
    local bottom_padding_cmd = ""

    test_ideal_writing_and_just_me = function()
        if (opts["ataraxis"]["ideal_writing_area_width"] > 0) then
            -- stuff
            local window_width = vim.api.nvim_eval("winwidth('%')")
            local ideal_writing_area_width = opts["ataraxis"]["ideal_writing_area_width"]

            if (ideal_writing_area_width == window_width) then
                cmd(
                    "echo 'TrueZen: the ideal_writing_area_width setting cannot have the same size as your current window, it must be smaller than " ..
                        window_width .. "'"
                )
            else
                total_left_right_width = window_width - ideal_writing_area_width

                if (total_left_right_width % 2 > 0) then
                    total_left_right_width = total_left_right_width + 1
                end

                local calculated_left_padding = total_left_right_width / 2
                local calculated_right_padding = total_left_right_width / 2

                left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
                right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
            end
        else
            if (opts["ataraxis"]["just_do_it_for_me"] == true) then
                -- calculate padding
                local calculated_left_padding = vim.api.nvim_eval("winwidth('%') / 4")
                local calculated_right_padding = vim.api.nvim_eval("winwidth('%') / 4")

                -- set padding
                left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
                right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
            else
                -- stuff
                left_padding_cmd = "vertical resize " .. opts["ataraxis"]["left_padding"] .. ""
                right_padding_cmd = "vertical resize " .. opts["ataraxis"]["right_padding"] .. ""
            end
        end
    end

    if (tz_left_padding ~= "NONE" or tz_right_padding ~= "NONE") then -- not equal to NONE
        -- right_padding_cmd = "vertical resize "..tz_right_padding..""
        if not (tz_left_padding == "NONE") then
            left_padding_cmd = "vertical resize " .. tz_left_padding .. ""
            cmd("unlet g:tz_left_padding")
        else
            left_padding_cmd = "vertical resize " .. opts["ataraxis"]["left_padding"] .. ""
        end

        if not (tz_right_padding == "NONE") then
            right_padding_cmd = "vertical resize " .. tz_right_padding .. ""
            cmd("unlet g:tz_right_padding")
        else
            right_padding_cmd = "vertical resize " .. opts["ataraxis"]["right_padding"] .. ""
        end
    else
        test_ideal_writing_and_just_me()
    end

    -------------------- left buffer
    cmd("leftabove vnew")
    cmd(left_padding_cmd)
    cmd(
        "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
    )
    -- fillchars()
    -------------------- left buffer

    -- return to middle buffer
    cmd("wincmd l")

    -------------------- right buffer
    cmd("vnew")
    cmd(right_padding_cmd)
    cmd(
        "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
    )
    -- fillchars()
    -------------------- right buffer

    -- return to middle buffer
    cmd("wincmd h")

    if not (tz_top_padding == "NONE") then
        top_padding_cmd = "resize " .. tz_top_padding .. ""
        cmd("leftabove new")
        cmd(top_padding_cmd)
        cmd(
            "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
        )

        -- cmd("unlet g:tz_top_padding")

        -- return to middle buffer
        cmd("wincmd j")

        top_use_passed_params = true
    else
        if (opts["ataraxis"]["top_padding"] > 0) then
            -- local top_padding_cmd = "resize "..opts["ataraxis"]["top_padding"]..""
            top_padding_cmd = "resize " .. opts["ataraxis"]["top_padding"] .. ""
            cmd("leftabove new")
            cmd(top_padding_cmd)
            cmd(
                "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
            )
            -- fillchars()

            -- return to middle buffer
            cmd("wincmd j")
        elseif (opts["ataraxis"]["top_padding"] == 0) then
            -- do nothing
        else
            cmd("echo 'invalid option set for top_padding param for TrueZen.nvim plugin. It can only be a number >= 0'")
        end
    end

    if not (tz_bottom_padding == "NONE") then
        bottom_padding_cmd = "resize " .. tz_bottom_padding .. ""
        cmd("rightbelow new")
        cmd(bottom_padding_cmd)
        cmd(
            "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
        )

        -- cmd("unlet g:tz_bottom_padding")

        -- return to middle buffer
        cmd("wincmd k")
        bottom_use_passed_params = true
    else
        if (opts["ataraxis"]["bottom_padding"] > 0) then
            -- local bottom_padding_cmd = "resize "..opts["ataraxis"]["bottom_padding"]..""
            bottom_padding_cmd = "resize " .. opts["ataraxis"]["bottom_padding"] .. ""
            cmd("rightbelow new")
            cmd(bottom_padding_cmd)
            cmd(
                "setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0"
            )
            -- fillchars()

            -- return to middle buffer
            cmd("wincmd k")
        elseif (opts["ataraxis"]["bottom_padding"] == 0) then
            -- do nothing
        else
            cmd(
                "echo 'invalid option set for bottom_padding param for TrueZen.nvim plugin. It can only be a number >= 0'"
            )
        end
    end

    --------------------------=== Fill chars ===--------------------------

    if (opts["ataraxis"]["disable_fillchars_configuration"] == false) then
        fillchar.store_fillchars()
        fillchar.set_fillchars()
    else
        -- nothing
    end

    --------------------------=== Fill chars ===--------------------------

	-- print("Got here (false)")
    -- mode_minimalist.main(2)
    -- hide whatever the user set to be hidden on the left hand side of vim
    -- cmd([[call BufDo("lua require'true-zen.services.left.init'.main(2)")]])

    --------------------------=== Hi Groups ===--------------------------

    if (opts["ataraxis"]["disable_bg_configuration"] == false) then
        hi_group.store_hi_groups(opts["ataraxis"]["affected_higroups"])
        hi_group.set_hi_groups(opts["ataraxis"]["custome_bg"], opts["ataraxis"]["affected_higroups"])
    else
        -- nothing
    end

    --------------------------=== Hi Groups ===--------------------------

    -- statusline stuff
    if (has_statusline_with_integration == true) then
        -- ignore
    else
        current_statusline = vim.api.nvim_eval("&statusline")
        cmd("setlocal statusline=-")
        goto no_need_to_force_hide_again
    end

    if (opts["ataraxis"]["force_hide_statusline"] == true) then
        cmd("setlocal statusline=-")
    end

    ::no_need_to_force_hide_again::

    -------------------------=== Integrations ===------------------------
    vim.api.nvim_exec(
        [[
		augroup false_integrations
			autocmd!
			autocmd BufWinEnter * if (&modifiable == 1) | execute "lua load_integrations(false)" | endif
		augroup END
	]],
        false
    )
    -------------------------=== Integrations ===------------------------

    -- everything will be skipped if there was more than one window open
    ::there_was_more_than_one_window::
end

return {
    ataraxis_true = ataraxis_true,
    ataraxis_false = ataraxis_false
}
