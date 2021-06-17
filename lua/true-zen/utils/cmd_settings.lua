local cmd = vim.cmd
local opts = require("true-zen.config").options
local before_after_cmds = require("true-zen.utils.before_after_cmd")

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

function map_settings(table, bool, ui_element)
    ui_element = ui_element or "NONE"

    if (bool == true) then
        if (opts["minimalist"]["store_and_restore_settings"] == true) then
			print("I ran true")
            before_after_cmds.restore_settings(ui_element)

            if (#opts["minimalist"]["show_vals_to_read"] > 0) then
                for opt, _ in pairs(opts["minimalist"]["show_vals_to_read"]) do
                    for inner_opt, _ in pairs(table) do
                        if (tostring(opts["minimalist"]["show_vals_to_read"][opt]) == tostring(inner_opt)) then
                            if string.find(inner_opt, "shown_") then
                                clean_and_exec(inner_opt, table[inner_opt], "shown_")
                            else
                                -- skip the option
                            end
                        end
                    end
                end
            end
        else
            for opt, _ in pairs(table) do
                if string.find(opt, "shown_") then
                    clean_and_exec(opt, table[opt], "shown_")
                else
                    -- skip the option
                end
            end
        end
    elseif (bool == false) then
        if (opts["minimalist"]["store_and_restore_settings"] == true) then
			print("I ran false")
			-- local minimalist_show = require("true-zen.services.mode-minimalist.init").minimalist_show
			-- print("minimalist_show = "..tostring(minimalist_show))
			if (minimalist_show == 1 or minimalist_show == nil) then
				if (ui_element == "BOTTOM") then
						before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
					-- if not (before_after_cmds.get_has_been_stored("BOTTOM") == true) then
					--     before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
					-- end
				elseif (ui_element == "TOP") then
						before_after_cmds.store_settings(opts["top"], "TOP")
					-- if not (before_after_cmds.get_has_been_stored("TOP") == true) then
					--     before_after_cmds.store_settings(opts["top"], "TOP")
					-- end
				elseif (ui_element == "LEFT") then
						before_after_cmds.store_settings(opts["left"], "LEFT")
					-- if not (before_after_cmds.get_has_been_stored("LEFT") == true) then
					--     before_after_cmds.store_settings(opts["left"], "LEFT")
					-- end
				else
					cmd("echo 'TrueZen: UI Element was not recognized'")
				end
			end
        end

        for opt, _ in pairs(table) do
            if string.find(opt, "hidden_") then
                clean_and_exec(opt, table[opt], "hidden_")
            else
                -- skip the option
            end
        end
    end
end

return {
    map_settings = map_settings
}
