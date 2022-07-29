local M = {}

local colors = require("true_zen.utils.colors")
local cnf = require("true_zen.config").options
local o = vim.o
local cmd = vim.cmd
local fn = vim.fn
local w = vim.w
local wo = vim.wo
local api = vim.api

local is_minimalized
local original_opts = {}

api.nvim_create_augroup("TrueZenMinimalist", {
	clear = true,
})

-- reference: https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers
local function alldo(run)
	local tab = fn.tabpagenr()
	local winnr = fn.winnr()
	local buffer = fn.bufnr("%")

	for _, command in pairs(run) do
		-- tapped together solution, but works! :)
		cmd([[windo if &modifiable == 1 && &buflisted == 1 && &bufhidden == "" | exe "let g:my_buf = bufnr(\"%\") | exe \"bufdo ]] .. command .. [[\" | exe \"buffer \" . g:my_buf" | endif]])
	end

	w.tz_buffer = nil

	cmd("tabn " .. tab)
	cmd(winnr .. " wincmd w")
	cmd("buffer " .. buffer)
end

local function save_opts()
	-- local suitable_window = fn.winnr()
	-- for _,ignored_buf_type in pairs(cnf.modes.minimalist.ignored_buf_types) do
	--
	-- end

	for user_opt, val in pairs(cnf.modes.minimalist.options) do
		original_opts[user_opt] = o[user_opt]
		o[user_opt] = val
	end

	original_opts.highlights = {
		StatusLine = colors.get_hl("StatusLine"),
		StatusLineNC = colors.get_hl("StatusLineNC"),
		TabLine = colors.get_hl("TabLine"),
		TabLineFill = colors.get_hl("TabLineFill"),
	}
end

function M.on()
	save_opts()

	-- hide (relative)number on every window or every tab
	alldo({ "set norelativenumber", "set nonumber" })

	-- hide statusline
	local bkg_color = colors.get_hl("Normal")["background"] or "NONE"
	colors.highlight("StatusLine", { fg = bkg_color, bg = bkg_color }, true)
	colors.highlight("StatusLineNC", { fg = bkg_color, bg = bkg_color }, true)
	colors.highlight("TabLine", { fg = bkg_color, bg = bkg_color }, true)
	colors.highlight("TabLineFill", { fg = bkg_color, bg = bkg_color }, true)

	for integration, val in pairs(cnf.integrations) do
		if val == true then
			require("true_zen.integrations." .. integration).on()
		end
	end

	is_minimalized = true
end

function M.off()
	api.nvim_create_augroup("TrueZenMinimalist", {
		clear = true,
	})

	if original_opts.number then
		alldo({ "set number" })
	end

	if original_opts.relativenumber then
		alldo({ "set relativenumber" })
	end

	original_opts.number = nil
	original_opts.relativenumber = nil

	for k,v in pairs(original_opts) do
		if k ~= "highlights" then
			o[k] = v
		end
	end

	for hi_group,props in pairs(original_opts["highlights"]) do
		colors.highlight(hi_group, { fg = props.foreground, bg = props.background }, true)
	end

	for integration, val in pairs(cnf.integrations) do
		if val == true then
			require("true_zen.integrations." .. integration).off()
		end
	end

	is_minimalized = false
end

function M.toggle()
	if is_minimalized then
		M.off()
	else
		M.on()
	end
end

return M
