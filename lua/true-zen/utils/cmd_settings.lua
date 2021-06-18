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
			print("true")
			print("Focusing = "..tostring(vim.g.__truezen_focus_loaded))
			if (vim.g.__truezen_focus_loaded == "false" or vim.g.__truezen_focus_loaded == nil) then
				before_after_cmds.restore_settings(ui_element)
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
			end
			-- print("I ran true")
			-- print("minimalist_show = "..tostring(require("true-zen.services.mode-minimalist.init").get_minimalist_show()))

        else
            for opt, _ in pairs(table) do
                if string.find(opt, "shown_") then
                    clean_and_exec(opt, table[opt], "shown_")
                end
            end
        end
    elseif (bool == false) then
        if (opts["minimalist"]["store_and_restore_settings"] == true) then
			print("false")
			-- print("Ataraxis hiding = "..vim.g.__truezen_ataraxis_hiding)
			-- local minimalist_show = require("true-zen.services.mode-minimalist.init").get_minimalist_show()

			if (vim.g.__truezen_ataraxis_hiding == "false" or vim.g.__truezen_ataraxis_hiding == nil) then
			-- if (vim.g.__truezen_minimalist_hiding == "false" or vim.g.__truezen_minimalist_hiding == nil) then
				print("got here")
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
			end

			-- if (minimalist_show == 0) then
			-- 	if (ui_element == "BOTTOM") then
			-- 		local bottom_has_been_stored = before_after_cmds.get_has_been_stored("BOTTOM")
			-- 		if (bottom_has_been_stored == false or bottom_has_been_stored == nil) then
			-- 		    before_after_cmds.store_settings(opts["bottom"], "BOTTOM")
			-- 		end
			-- 	elseif (ui_element == "TOP") then
			-- 		local top_has_been_stored = before_after_cmds.get_has_been_stored("TOP")
			-- 		if (top_has_been_stored == true or top_has_been_stored == nil) then
			-- 		    before_after_cmds.store_settings(opts["top"], "TOP")
			-- 		end
			-- 	elseif (ui_element == "LEFT") then
			-- 		local left_has_been_stored = before_after_cmds.get_has_been_stored("LEFT")
			-- 		if (left_has_been_stored == true or left_has_been_stored == nil) then
			-- 		    before_after_cmds.store_settings(opts["left"], "LEFT")
			-- 		end
			-- 	else
			-- 		cmd("echo 'TrueZen: UI Element was not recognized'")
			-- 	end
			-- end
        end

        for opt, _ in pairs(table) do
            if string.find(opt, "hidden_") then
                clean_and_exec(opt, table[opt], "hidden_")
            end
        end
    end
end

return {
    map_settings = map_settings
}
