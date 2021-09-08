local opts = require("true-zen.config").options
local mode_minimalist = require("true-zen.services.modes.mode-minimalist.init")
local hi_group = require("true-zen.services.modes.mode-ataraxis.modules.hi_group")
local fillchar = require("true-zen.services.modes.mode-ataraxis.modules.fillchar")
local integrations_loader = require("true-zen.services.integrations.modules.integrations_loader")
local special_integrations_loader = require("true-zen.services.integrations.modules.special_integrations_loader")
local colors = require("true-zen.utils.colors")

local cmd = vim.cmd
local api = vim.api
local o = vim.o
local fn = vim.fn

local iwaw_proportion
local truezen_layout
local splitbelow
local splitright
local hidden
local x_axis
local y_axis
local winhl
local normal_bg
local file_exists
local minimalist_prev_status
local statusline

local M = {}

function M.get_axis_length(axis)
	if axis == "x" then
		return x_axis
	end

	return y_axis
end

function M.set_layout(layout)
	truezen_layout = layout
end

function M.get_layout()
	return truezen_layout
end

function M.set_axis_length(axis, value)
	if axis == "x" then
		x_axis = value
	else
		y_axis = value
	end
end

local function set_minimalist_prev_status(val)
	minimalist_prev_status = val
end

local function get_minimalist_prev_status()
	return minimalist_prev_status
end

local function set_winhl(val)
	winhl = val
end

local function get_winhl()
	return winhl
end

local function set_iwaw_proportion(val)
	iwaw_proportion = val
end

local function get_iwaw_proportion()
	return iwaw_proportion
end

local function set_normal_bg(color)
	normal_bg = color
end

local function get_normal_bg()
	return normal_bg
end

local function set_file_exists(val)
	file_exists = val
end

local function get_file_exists()
	return file_exists
end

local function set_statusline(sl)
	statusline = sl
end

local function get_statusline()
	return statusline
end

local function set_split(split, val)
	if split == "splitbelow" then
		splitbelow = val
	else
		splitright = val
	end
end

local function get_split(split)
	if split == "splitbelow" then
		return splitbelow
	else
		return splitright
	end
end

local function get_hidden()
	return hidden
end

local function set_hidden(val)
	hidden = val
end

local function statusline_autocmd(co) -- co = [to] carry out
	if co == "start" then
		api.nvim_exec(
			[[
			augroup truezen_tmp_statusline
				autocmd!
				autocmd VimResume,FocusGained,BufEnter,WinEnter,BufWinEnter * let &statusline='%#Normal# '
			augroup end
		]],
			false
		)
	else
		api.nvim_exec(
			[[
			augroup truezen_tmp_statusline
				autocmd!
			augroup end
		]],
			false
		)
	end
end

local function ensure_settings()
	if o.splitbelow == false then
		set_split("splitbelow", false)
		o.splitbelow = true
	else
		set_split("splitbelow", true)
	end

	if o.splitright == false then
		set_split("splitright", false)
		o.splitright = true
	else
		set_split("splitright", true)
	end

	if o.hidden == false then
		set_hidden(false)
		o.hidden = true
	else
		set_hidden(true)
	end
end

local function restore_settings()
	o.splitbelow = get_split("splitbelow") or true
	o.splitright = get_split("splitright") or true
	o.hidden = get_hidden() or true
end

local function unlet_padding_vars()
	api.nvim_exec(
		[[
		if exists("g:tz_top_padding") | unlet g:tz_top_padding | endif
		if exists("g:tz_bottom_padding") | unlet g:tz_bottom_padding | endif
		if exists("g:tz_left_padding") | unlet g:tz_left_padding | endif
		if exists("g:tz_right_padding") | unlet g:tz_right_padding | endif
	]],
		false
	)
end

local function unlet_sys_vars()
	api.nvim_exec(
		[[
		if exists("g:tz_tmp_statusline") | unlet g:tz_tmp_statusline | endif
	]],
		false
	)
end

local function gen_background()
	local style = opts["modes"]["ataraxis"]["custom_bg"][1]
	local bg_prop = opts["modes"]["ataraxis"]["custom_bg"][2]

	if style == "darken" then
		local normal = colors.get_hl("Normal")

		local user_bg
		local truezen_bg
		local aux_bg

		if normal and normal.background then
			user_bg = normal.background
			truezen_bg = colors.darken(user_bg, bg_prop)
		else
			user_bg = nil

			if o.bg == "dark" then
				aux_bg = "#111921"
				truezen_bg = colors.darken(aux_bg, bg_prop)
			else
				aux_bg = "#363636"
				truezen_bg = colors.darken("#363636", bg_prop)
			end
		end

		set_normal_bg({ user_bg, truezen_bg }) -- [1] = user bg; [2] = truezen bg

		cmd(("highlight TrueZenBg guibg=%s guifg=%s"):format(truezen_bg, truezen_bg))
		cmd(("highlight TrueZenAuxBg guibg=%s"):format((user_bg or aux_bg)))
		set_winhl("winhighlight=Normal:TrueZenBg")
	elseif style == "solid" then
		local normal = colors.get_hl("Normal")
		set_normal_bg({ normal.background, bg_prop }) -- [1] = user bg; [2] = truezen bg
		cmd(("highlight TrueZenBg guibg=%s guifg=%s"):format(bg_prop, bg_prop))
		cmd(("highlight TrueZenAuxBg guibg=%s"):format(normal.background))
		set_winhl("winhighlight=Normal:TrueZenBg")
	else
		set_winhl("")
	end
end

local function gen_window_specs(gen_command, command, extra)
	if command ~= "" then
		cmd(gen_command)
		cmd(command)
		cmd(
			[[
			setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0 ]]
				.. get_winhl()
				.. [[ | let w:truezen_window = 'true']]
		)

		if extra ~= nil then
			cmd(extra)
		end
	end
end

function M.layout(action)
	if action == "generate" then
		ensure_settings()

		tz_top_padding = api.nvim_eval([[get(g:,"tz_top_padding", "NONE")]])
		tz_left_padding = api.nvim_eval([[get(g:,"tz_left_padding", "NONE")]])
		tz_right_padding = api.nvim_eval([[get(g:,"tz_right_padding", "NONE")]])
		tz_bottom_padding = api.nvim_eval([[get(g:, "tz_bottom_padding", "NONE")]])

		local left_padding_cmd = ""
		local right_padding_cmd = ""
		local top_padding_cmd = ""
		local bottom_padding_cmd = ""

		if tz_left_padding ~= "NONE" or tz_right_padding ~= "NONE" then
			if not (tz_left_padding == "NONE") then
				left_padding_cmd = "vertical resize " .. tz_left_padding .. ""
			else
				left_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["left_padding"] .. ""
			end

			if not (tz_right_padding == "NONE") then
				right_padding_cmd = "vertical resize " .. tz_right_padding .. ""
			else
				right_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["right_padding"] .. ""
			end
		else
			if opts["modes"]["ataraxis"]["ideal_writing_area_width"][1] > 0 then
				local ideal_writing_area_width

				if #opts["modes"]["ataraxis"]["ideal_writing_area_width"] >= 2 then
					local min = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
					local max = opts["modes"]["ataraxis"]["ideal_writing_area_width"][2]
					local pick = opts["modes"]["ataraxis"]["ideal_writing_area_width"][3]
					local diff = max - min

					if get_iwaw_proportion() == nil then
						set_iwaw_proportion(diff / api.nvim_list_uis()[1]["width"])
					end

					local unasserted_iwaw = get_iwaw_proportion() * api.nvim_list_uis()[1]["width"]

					if unasserted_iwaw > max then
						ideal_writing_area_width = max
					elseif unasserted_iwaw < min then
						ideal_writing_area_width = min
					else
						if pick == nil then
							ideal_writing_area_width = math.floor(unasserted_iwaw + 0.5)
						else
							if pick == "max" then
								ideal_writing_area_width = max
							elseif pick == "min" then
								ideal_writing_area_width = min
							end
						end
					end
				else
					ideal_writing_area_width = opts["modes"]["ataraxis"]["ideal_writing_area_width"][1]
				end

				local window_width = api.nvim_list_uis()[1]["width"]

				if ideal_writing_area_width >= window_width then
					ideal_writing_area_width = window_width - 1
				end

				local total_left_right_width = window_width - ideal_writing_area_width

				if total_left_right_width % 2 > 0 then
					total_left_right_width = total_left_right_width + 1
				end

				local calculated_left_padding = total_left_right_width / 2
				local calculated_right_padding = total_left_right_width / 2

				left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
				right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
			else
				if opts["modes"]["ataraxis"]["auto_padding"] == true then
					local calculated_left_padding = api.nvim_eval("winwidth('%') / 4")
					local calculated_right_padding = api.nvim_eval("winwidth('%') / 4")

					left_padding_cmd = "vertical resize " .. calculated_left_padding .. ""
					right_padding_cmd = "vertical resize " .. calculated_right_padding .. ""
				else
					left_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["left_padding"] .. ""
					right_padding_cmd = "vertical resize " .. opts["modes"]["ataraxis"]["right_padding"] .. ""
				end
			end
		end

		-- TODO: REPLACE THIS WITH PCALL TO AVOID NEGATIVE NUMBERS
		if tz_top_padding ~= "NONE" then
			if tz_top_padding ~= 0 then
				top_padding_cmd = "resize " .. tz_top_padding .. ""
			end
		else
			local user_top = opts["modes"]["ataraxis"]["top_padding"]
			if user_top ~= 0 then
				top_padding_cmd = "resize " .. user_top .. ""
			end
		end

		if tz_bottom_padding ~= "NONE" then
			if tz_bottom_padding ~= 0 then
				bottom_padding_cmd = "resize " .. tz_bottom_padding .. ""
			end
		else
			local user_bottom = opts["modes"]["ataraxis"]["bottom_padding"]
			if user_bottom ~= 0 then
				bottom_padding_cmd = "resize " .. user_bottom .. ""
			end
		end

		gen_window_specs("leftabove vnew", left_padding_cmd, "wincmd l") -- left buffer
		gen_window_specs("vnew", right_padding_cmd, "wincmd h") -- right buffer
		gen_window_specs("leftabove new", top_padding_cmd, "wincmd j") -- top buffer
		gen_window_specs("rightbelow new", bottom_padding_cmd, "wincmd k") -- bottom buffer
		-- final position: middle buffer

		if M.get_axis_length("x") == nil then
			M.set_axis_length("x", api.nvim_eval([[winwidth('%')]]))
			M.set_axis_length("y", api.nvim_eval([[winheight('%')]]))
		end

		cmd([[let g:truezen_main_window = win_getid()]])
		cmd([[let w:truezen_window = 'true']])
		M.set_layout(api.nvim_eval([[winrestcmd()]]))
	elseif action == "destroy" then
		cmd("only")

		if get_file_exists() then
			cmd("q")
		end

		unlet_padding_vars()
	end
end

local function tranq_normal_bg()
	local style = opts["modes"]["ataraxis"]["custom_bg"][1]
	if style == "darken" then
		cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
	elseif style == "solid" then
		cmd([[hi Normal guibg=]] .. get_normal_bg()[2]) -- truezen bg
	end
end

local function restore_normal_bg()
	local style = opts["modes"]["ataraxis"]["custom_bg"][1]
	if style == "darken" then
		cmd([[hi Normal guibg=]] .. (get_normal_bg()[1] or "none")) -- user bg
	elseif style == "solid" then
		cmd([[hi Normal guibg=]] .. get_normal_bg()[1]) -- user bg
	end
end

function M.on()
	local cursor_pos = fn.getpos(".")

	special_integrations_loader.unload_integrations()
	integrations_loader.unload_integrations()

	if fn.filereadable(fn.expand("%:p")) == 1 then
		cmd("tabe %")
		set_file_exists(true)
	end

	if mode_minimalist.get_status() == "off" or mode_minimalist.get_status() == nil then
		mode_minimalist.on()
		set_minimalist_prev_status(false)
	else
		set_minimalist_prev_status(true)
	end

	if opts["modes"]["ataraxis"]["bg_configuration"] == true then
		if get_winhl() == nil then
			gen_background()
		end

		tranq_normal_bg()
	end

	M.layout("generate")
	fillchar.store_fillchars()
	fillchar.set_fillchars()

	if opts["modes"]["ataraxis"]["bg_configuration"] == true then
		hi_group.store_hi_groups(opts["modes"]["ataraxis"]["affected_higroups"])

		local bg_color = opts["modes"]["ataraxis"]["custom_bg"][2]
		if opts["modes"]["ataraxis"]["custom_bg"][1] == "darken" then
			bg_color = ""
		end

		hi_group.set_hi_groups(bg_color or "")

		cmd([[setlocal winhighlight=Normal:TrueZenAuxBg]])
	end

	local statusline_integration = integrations_loader.get_has_line_with_integration()
	if statusline_integration == nil or statusline_integration == false then
		cmd([[let g:tz_tmp_statusline=&statusline]])
		cmd([[setlocal statusline=-]]) -- hide it for the win
		local tz_statusline = api.nvim_eval([[get(g:,"tz_tmp_statusline", "NONE")]])
		if tz_statusline ~= "" or tz_statusline ~= "NONE" then
			set_statusline(tz_statusline)
			statusline_autocmd("start")
		end
	end

	fn.setpos(".", cursor_pos)
end

function M.off()
	local cursor_pos

	if api.nvim_eval([[get(g:,"truezen_main_window", "no")]]) == fn.win_getid() then
		cursor_pos = fn.getpos(".")
	end

	M.layout("destroy")
	if get_minimalist_prev_status() == false then
		mode_minimalist.off()
	end

	local statusline_integration = integrations_loader.get_has_line_with_integration()
	integrations_loader.load_integrations()
	special_integrations_loader.load_integrations()

	-- vim.g.si = integrations_loader.get_has_line_with_integration()
	if statusline_integration == nil or statusline_integration == false then
		statusline_autocmd("stop")
		if get_statusline() ~= nil and get_statusline() ~= "" then
			cmd([[let &statusline=g:tz_tmp_statusline]])
		end
	end

	fillchar.restore_fillchars()

	if opts["modes"]["ataraxis"]["bg_configuration"] == true then
		hi_group.restore_hi_groups()
		restore_normal_bg()
	end

	restore_settings()
	unlet_sys_vars()

	if cursor_pos ~= nil then
		fn.setpos(".", cursor_pos)
		cursor_pos = nil
	end
end

return M
