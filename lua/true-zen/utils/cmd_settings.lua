

local cmd = vim.cmd
local opts = require("true-zen.config").options


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

local function clean_and_exec(opt, table_opt, remove_str, user_wants_conf)
	user_wants_conf = user_wants_conf or 0
	final_opt = tostring(opt:gsub(remove_str, ""))

	if (user_wants_conf == 1) then
		-- user_opts[final_opt] = vim.api.nvim_eval("&"..final_opt.."")
		local current_state = vim.api.nvim_eval("&"..final_opt.."")

		if (type(table_opt) == "boolean") then
			-- to_cmd = test_bool(final_opt, table_opt)
			if (current_state == 1) then
				table.insert(user_opts, "setlocal "..final_opt)
			elseif (current_state == 0) then
				table.insert(user_opts, "setlocal no"..final_opt)
			end

		elseif (type(table_opt) == "number") then
			table.insert(user_opts, "setlocal "..final_opt.."="..current_state.."")
		elseif (type(table_opt) == "string") then
			table.insert(user_opts, "setlocal "..final_opt.."="..current_state.."")
		end
	end

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


function map_settings(table, bool)


	if (bool == true) then
		if (opts["minimalist"]["save_and_restore_settings_when_untoggled"] == true) then
			-- cmd("echo 'I RAN 1'")
			if (user_opts == nil) then
				-- cmd("echo 'I RAN 2'")
				-- can't restore because there is nothing to be restored
				cmd("echo 'Unfortunately there was nothing to restore from your settings. Session will remain as it was before executing this command.'")
				goto done_with_showing
			else
				-- cmd("echo 'I RAN 3'")
				if (#user_opts > 0) then		-- table not empty
					-- cmd("echo 'I RAN 5'")
					for opt, _ in pairs(user_opts) do
						-- cmd("echo 'opt = "..opt.."'")
						cmd(user_opts[opt])
					end
					goto done_with_showing
				end
			end

		end
		-- cmd("echo 'I RAN 6'")

		for opt, _ in pairs(table) do
			if string.find(opt, "shown_") then
				clean_and_exec(opt, table[opt], "shown_", 0)
			else
				-- skip the option
			end
		end

		::done_with_showing::

	elseif (bool == false) then
		if (opts["minimalist"]["save_and_restore_settings_when_untoggled"] == true) then
			-- cmd("echo 'I RAN!!'")
			user_wants_his_config = 1
			user_opts = {}
		end

		for opt, _ in pairs(table) do
			if string.find(opt, "hidden_") then
				clean_and_exec(opt, table[opt], "hidden_", user_wants_his_config)
			else
				-- skip the option
			end
		end
	elseif (bool == "false_but_in_mode") then
		cmd("echo 'I WAS THREE'")

		for opt, _ in pairs(table) do
			if string.find(opt, "hidden_") then
				clean_and_exec(opt, table[opt], "hidden_", 0)
			else
				-- skip the option
			end
		end
	end
end



return {
	map_settings = map_settings
}
