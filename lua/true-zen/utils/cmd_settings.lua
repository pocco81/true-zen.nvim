

local cmd = vim.cmd
local before_after_cmd = require("lua.true-zen.utils.before_after_cmd")


local function test_bool(final_opt, var)
	
	if (var == true) then
		return "setlocal "..final_opt..""
	elseif (var == false) then
		return "setlocal no"..final_opt..""
	end

end

local function test_num(final_opt, num)
	return "setlocal "..final_opt.."="..num..""
end

local function test_str(final_opt, str)
	return "setlocal "..final_opt.."="..str..""
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

		if (opts["minimalist"]["save_and_restore_settings_when_untoggled"] == true) then
			before_after_cmd.restore_settings(ui_element)
			goto skip_truezen_config
		end


		for opt, _ in pairs(table) do
			if string.find(opt, "shown_") then
				clean_and_exec(opt, table[opt], "shown_")
			else
				-- skip the option
			end
		end
		
		::skip_truezen_config::
	elseif (bool == false) then

		for opt, _ in pairs(table) do
			if (opts["minimalist"]["save_and_restore_settings_when_untoggled"] == true) then
				before_after_cmd.save_settings(opt, table[opt], "hidden_", ui_element)
			end


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
