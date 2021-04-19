

local cmd = vim.cmd


local function test_bool(var, final_opt)
	
	if (var == true) then
		return "setlocal "..final_opt..""
	elseif (var == false) then
		return "setlocal no"..final_opt..""
	end

end

local function test_num(final_opt, num)
	return "setlocal "..final_opt.."="..num..""
end

local function clean_and_exec(opt, table_opt, remove_str)
	final_opt = opt:gsub(remove_str, "")
	if (type(table_opt) == "boolean") then
		to_cmd = test_bool(table_opt, final_opt)
		cmd(to_cmd)
	elseif (type(table_opt) == "number") then
		to_cmd = test_num(final_opt, table_opt)
		cmd(to_cmd)
	end
end


function map_settings(table, bool)


	if (bool == true) then
		for opt, _ in pairs(table) do
			if string.find(opt, "shown_") then
				clean_and_exec(opt, table[opt], "shown_")
			else
				-- skip the option
			end
		end
	elseif (bool == false) then
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
