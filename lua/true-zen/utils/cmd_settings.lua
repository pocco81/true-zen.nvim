local cmd = vim.cmd
local opts = require("true-zen.config").options
local before_after_cmds = require("true-zen.utils.before_after_cmd")
local affected_buffers = {}

local function test_bool(final_opt, var)
    if (var == true) then
        return "setlocal " .. final_opt .. ""
    elseif (var == false) then
        return "setlocal no" .. final_opt .. ""
    end
end

local function test_num(final_opt, num)
    return "setlocal " .. final_opt .. "=" .. num .. ""
end

local function test_str(final_opt, str)
    return "setlocal " .. final_opt .. "=" .. str .. ""
end

local function add_affected_buffers(buffer)
	table.insert(affected_buffers, buffer)
end

local function get_affected_buffers()
	return affected_buffers
end

local function clean_and_exec(opt, table_opt, remove_str)
    final_opt = opt:gsub(remove_str, "")

    if (type(table_opt) == "boolean") then
        to_cmd = test_bool(final_opt, table_opt)
        cmd(to_cmd)
    elseif (type(table_opt) == "number") then
        to_cmd = test_num(final_opt, table_opt)
        cmd(to_cmd)
    elseif (type(table_opt) == "string") then
        to_cmd = test_str(final_opt, table_opt)
        cmd(to_cmd)
    end
end

local function analyse_ui_element(table, ui_element, state)
    if (state == true) then
        if (ui_element == "BOTTOM") then
            local bottom_has_been_stored = before_after_cmds.get_has_been_stored("BOTTOM")

            if (bottom_has_been_stored == false or bottom_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
            end
        elseif (ui_element == "TOP") then
            local top_has_been_stored = before_after_cmds.get_has_been_stored("TOP")

            if (top_has_been_stored == true or top_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["top"], "TOP")
            end
        elseif (ui_element == "LEFT") then
            local left_has_been_stored = before_after_cmds.get_has_been_stored("LEFT")

            if (left_has_been_stored == true or left_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["left"], "LEFT")
            end
        else
            cmd("echo 'TrueZen: UI Element was not recognized'")
        end

        before_after_cmds.restore_settings(ui_element)
        if (#opts["minimalist"]["show_vals_to_read"] > 0) then
            for opt, _ in pairs(opts["minimalist"]["show_vals_to_read"]) do
                for inner_opt, _ in pairs(table) do
                    if (tostring(opts["minimalist"]["show_vals_to_read"][opt]) == tostring(inner_opt)) then
                        if string.find(inner_opt, "shown_") then
                            clean_and_exec(inner_opt, table[inner_opt], "shown_")
                        end
                    end
                end
            end
        end
    else
        if (ui_element == "BOTTOM") then
            local bottom_has_been_stored = before_after_cmds.get_has_been_stored("BOTTOM")
            if (bottom_has_been_stored == false or bottom_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
            end
        elseif (ui_element == "TOP") then
            local top_has_been_stored = before_after_cmds.get_has_been_stored("TOP")
            if (top_has_been_stored == true or top_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["top"], "TOP")
            end
        elseif (ui_element == "LEFT") then
            local left_has_been_stored = before_after_cmds.get_has_been_stored("LEFT")
            if (left_has_been_stored == true or left_has_been_stored == nil) then
                before_after_cmds.store_settings(opts["left"], "LEFT")
            end
        else
            cmd("echo 'TrueZen: UI Element was not recognized'")
        end
        for opt, _ in pairs(table) do
            if string.find(opt, "hidden_") then
                clean_and_exec(opt, table[opt], "hidden_")
            end
        end
    end
end

function map_settings(table, bool, ui_element)
    ui_element = ui_element or "NONE"

    if (bool == true) then
        if (opts["minimalist"]["store_and_restore_settings"] == true) then
            local analyse = false

            -- if (vim.g.__truezen_focus_loaded == "false") then
            --     analyse = false
            -- end

            if (vim.g.__truezen_minimalist_hiding == "false") then
                analyse = true
            elseif (vim.g.__truezen_minimalist_hiding == "true") then
                analyse = false
            end

            if (analyse == true) then
                before_after_cmds.restore_settings(ui_element)
                analyse_ui_element(table, ui_element, true)
			else
                before_after_cmds.restore_settings(ui_element)
            end
        else
            for opt, _ in pairs(table) do
                if string.find(opt, "shown_") then
                    clean_and_exec(opt, table[opt], "shown_")
                end
            end
        end
    elseif (bool == false) then
        if (opts["minimalist"]["store_and_restore_settings"] == true) then

            if (vim.g.__truezen_minimalist_hiding == "true" or vim.g.__truezen_minimalist_hiding == nil) then
                analyse_ui_element(table, ui_element, false)
            else
                -- if (vim.g.__truezen_ataraxis_hiding == "true") then
                    for opt, _ in pairs(table) do
                        if string.find(opt, "hidden_") then
                            clean_and_exec(opt, table[opt], "hidden_")
                        end
                    end
                -- end
            end
		else
			for opt, _ in pairs(table) do
				if string.find(opt, "hidden_") then
					clean_and_exec(opt, table[opt], "hidden_")
				end
			end
        end
    end
end

return {
    map_settings = map_settings
}
