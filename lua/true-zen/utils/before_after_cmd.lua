

-- local opts = require("true-zen.config").options
local cmd = vim.cmd

-- local bottom = require("true-zen.services.bottom.init")
-- local top = require("true-zen.services.top.init")
-- local left = require("true-zen.services.left.init")



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



local function clean_and_append(opt, table_opt, remove_str)
	local final_opt = opt:gsub(remove_str, "")
	local current_state = vim.api.nvim_eval("&"..final_opt.."")

	if (type(current_state) == "boolean") then
		local to_cmd = test_bool(final_opt, current_state)
		cmd("echo 'To CMD = "..to_cmd.."'")
		return to_cmd
	elseif (type(current_state) == "number") then
		local to_cmd = test_num(final_opt, current_state)
		cmd("echo 'To CMD = "..to_cmd.."'")
		return to_cmd
	elseif (type(current_state) == "string") then
		local to_cmd = test_str(final_opt, current_state)
		cmd("echo 'To CMD = "..to_cmd.."'")
		return to_cmd
	end
end


local function read_call(opt, value_opt)

	if string.find(opt, "shown_") then
		return clean_and_append(opt, value_opt, "shown_")
	else
		return nil
	end
	
end

function store_settings(table_local, ui_element)


	if (ui_element == "TOP") then

		user_top_opts = {}
		for opt, _ in pairs(table_local) do
			local final_cmd = read_call(opt, table_local[opt])

			if (final_cmd == nil) then
				-- ignore
			else
				cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_top_opts, final_cmd)
				cmd("echo ' '")
			end


		end
	elseif (ui_element == "BOTTOM") then

		user_bottom_opts = {}
		for opt, _ in pairs(table_local) do
			local final_cmd = read_call(opt, table_local[opt])

			if (final_cmd == nil) then
				-- ignore
			else
				cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_bottom_opts, final_cmd)
				cmd("echo ' '")
			end
		end
	elseif (ui_element == "LEFT") then

		user_left_opts = {}
		for opt, _ in pairs(table_local) do
			local final_cmd = read_call(opt, table_local[opt])

			if (final_cmd == nil) then
				-- ignore
			else
				cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_left_opts, final_cmd)
				cmd("echo ' '")
			end
		end
	end
	
end

function restore_settings(ui_element)

	ui_element = ui_element or "NONE"
	user_bottom_opts = user_bottom_opts or nil
	user_left_opts = user_left_opts or nil
	user_top_opts = user_top_opts or nil


	if (ui_element == "BOTTOM") then
		if (user_bottom_opts == nil) then
			-- nothing
		else
			for opt, _ in pairs(user_bottom_opts) do
				cmd("echo 'Opt = "..opt.."; Value = "..user_bottom_opts[opt].."'")
			end
		end
	elseif (ui_element == "TOP") then
		if (user_top_opts == nil) then
			-- ignore
		else
			for opt, _ in pairs(user_top_opts) do
				cmd("echo 'Opt = "..opt.."; Value = "..user_top_opts[opt].."'")
			end
		end
	elseif (ui_element == "LEFT") then
		if (user_left_opts == nil) then
			-- ignore
		else
			for opt, _ in pairs(user_left_opts) do
				cmd("echo 'Opt = "..opt.."; Value = "..user_left_opts[opt].."'")
			end
		end

	end

end


--[[

return save_settings && restore_settings

save_settings
1. check which UI element is it part of
2. prepare the var and parse it
3. add it to the corresponding table

restore_settings
1. check which UI element is going to be restored
2. restore everything
3. skip the other stuff at cmd_settings




local function iterate_and_run(table)

	for opt, _ in pairs(table) do
		cmd(""..opt.."")
	end
	
end


local function check_table_and_insert(element, table)

	table = table or "NONE"

	if (table == "NONE") then
		-- skip it
	else
		if (table == "TOP") then
			table.insert(user_top_opts, element)
		elseif (table == "BOTTOM") then
			table.insert(user_bottom_opts, element)
		elseif (table == "LEFT") then
			table.insert(user_left_opts, element)
		else
			cmd("echo 'unrecognized UI element'")
		end
	end
	
end



function store_settings(opt_index, opt_value, remove_str, ui_element)

	ui_element = ui_element or "NONE"

	local final_opt = opt_index:gsub(remove_str, "")
	local current_state = vim.api.nvim_eval("&"..final_opt.."")


	if (type(opt_value) == "boolean") then

		if (current_state == 1) then
			to_cmd = "setlocal "..final_opt..""
			check_table_and_insert(to_cmd, ui_element)
		elseif (current_state == 0) then
			to_cmd = "setlocal no"..final_opt
		end

	elseif (type(opt_value) == "number") then
		to_cmd = "setlocal "..final_opt.."="..current_state..""
		check_table_and_insert(to_cmd, ui_element)
	elseif (type(opt_value) == "string") then
		to_cmd = "setlocal "..final_opt.."="..current_state..""
		check_table_and_insert(to_cmd, ui_element)
	end


	
	
end

function restore_settings(ui_element, is_toggled)

	ui_element = ui_element or "NONE"
	is_toggled = is_toggled or 0

	if (ui_element == "NONE") then
		-- skip it
	else
		if (ui_element == "TOP") then
			if (is_toggled == 1) then
				iterate_and_run(user_top_opts)
			end
		elseif (ui_element == "BOTTOM") then
			if (is_toggled == 1) then
				iterate_and_run(user_bottom_opts)
			end
		elseif (ui_element == "LEFT") then
			if (is_toggled == 1) then
				iterate_and_run(user_left_opts)
			end
		else
			cmd("echo 'unrecognized UI element'")
		end
	end
	
end

]]--


return {
	store_settings = store_settings,
	restore_settings = restore_settings
}

