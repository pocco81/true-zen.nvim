

-- local opts = require("true-zen.config").options
local cmd = vim.cmd

function get_has_been_stored(element)
	if (element == "LEFT") then
		return left_has_been_stored
	elseif (element == "TOP") then
		return top_has_been_stored
	elseif (element == "BOTTOM") then
		return bottom_has_been_stored
	end
end

function get_has_been_restored(element)
	if (element == "LEFT") then
		return left_has_been_restored
	elseif (element == "TOP") then
		return top_has_been_restored
	elseif (element == "BOTTOM") then
		return bottom_has_been_restored
	end
end

local function test_bool(final_opt, var)
	

	local current_state = vim.api.nvim_eval("&"..final_opt.."")

	if (current_state == 1) then
		return "setlocal "..final_opt..""
	elseif (current_state == 0) then
		return "setlocal no"..final_opt..""
	end

end

local function test_num(final_opt, num)
	local current_state = vim.api.nvim_eval("&"..final_opt.."")

	return "setlocal "..final_opt.."="..current_state..""
end

local function test_str(final_opt, str)
	local current_state = vim.api.nvim_eval("&"..final_opt.."")

	return "setlocal "..final_opt.."="..current_state..""
end



local function clean_and_append(opt, table_opt, remove_str)
	local final_opt = opt:gsub(remove_str, "")


	if (type(table_opt) == "boolean") then
		to_cmd = test_bool(final_opt, table_opt)
		-- cmd("echo 'To cmd = "..tostring(to_cmd).."'")
		return to_cmd
	elseif (type(table_opt) == "number") then
		to_cmd = test_num(final_opt, table_opt)
		-- cmd("echo 'To cmd = "..tostring(to_cmd).."'")
		return to_cmd
	elseif (type(table_opt) == "string") then
		to_cmd = test_str(final_opt, table_opt)
		-- cmd("echo 'To cmd = "..tostring(to_cmd).."'")
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
				-- cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_top_opts, final_cmd)
				-- cmd("echo ' '")
			end


		end
		top_has_been_stored = true
	elseif (ui_element == "BOTTOM") then

		user_bottom_opts = {}
		for opt, _ in pairs(table_local) do
			local final_cmd = read_call(opt, table_local[opt])

			if (final_cmd == nil) then
				-- ignore
			else
				-- cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_bottom_opts, final_cmd)
				-- cmd("echo ' '")
			end
		end
		bottom_has_been_stored = true
	elseif (ui_element == "LEFT") then

		user_left_opts = {}
		for opt, _ in pairs(table_local) do
			local final_cmd = read_call(opt, table_local[opt])

			if (final_cmd == nil) then
				-- ignore
			else
				-- cmd("echo 'Final CMD = "..final_cmd.."'")
				table.insert(user_left_opts, final_cmd)
				-- cmd("echo ' '")
			end
		end
		left_has_been_stored = true
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
				-- cmd("echo 'Opt = "..opt.."; Value = "..user_bottom_opts[opt].."'")
				cmd(user_bottom_opts[opt])
			end
			-- cmd("echo ' '")
			bottom_has_been_restored = true
		end
		bottom_has_been_stored = false
	elseif (ui_element == "TOP") then
		if (user_top_opts == nil) then
			-- ignore
		else
			for opt, _ in pairs(user_top_opts) do
				-- cmd("echo 'Opt = "..opt.."; Value = "..user_top_opts[opt].."'")
				cmd(user_top_opts[opt])
			end
			-- cmd("echo ' '")
			top_has_been_restored = true
		end
		top_has_been_stored = false
	elseif (ui_element == "LEFT") then
		if (user_left_opts == nil) then
			-- ignore
		else
			for opt, _ in pairs(user_left_opts) do
				-- cmd("echo 'Opt = "..opt.."; Value = "..user_left_opts[opt].."'")
				cmd(user_left_opts[opt])
			end
			-- cmd("echo ' '")

			left_has_been_restored = true
		end

		left_has_been_stored = false

	end


end



return {
	store_settings = store_settings,
	restore_settings = restore_settings,
	get_has_been_stored = get_has_been_stored,
	get_has_been_restored = get_has_been_restored
}

