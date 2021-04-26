

-- local opts = require("true-zen.config").options
local cmd = vim.cmd

-- local bottom = require("true-zen.services.bottom.init")
-- local top = require("true-zen.services.top.init")
-- local left = require("true-zen.services.left.init")


user_left_opts = {}
user_bottom_opts = {}
user_top_opts = {}


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


]]--


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



function save_settings(opt_index, opt_value, remove_str, ui_element)

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
			if (top.top_show == 1) then
				iterate_and_run(user_top_opts)
			end
		elseif (ui_element == "BOTTOM") then
			if (bottom.bottom_show == 1) then
				iterate_and_run(user_bottom_opts)
			end
		elseif (ui_element == "LEFT") then
			if (left.left_show == 1) then
				iterate_and_run(user_left_opts)
			end
		else
			cmd("echo 'unrecognized UI element'")
		end
	end
	
end



return {
	save_settings = save_settings,
	restore_settings = restore_settings
}

