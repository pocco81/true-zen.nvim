local M = {}

local colors = require("true_zen.utils.colors")
local echo = require("true_zen.utils.echo")
local o = vim.o
local cmd = vim.cmd
local fn = vim.fn
local w = vim.w

local is_minimalized
local original_opts = {}

-- reference: https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers
local function alldo(run)
	local tab = fn.tabpagenr()
	local winnr = fn.winnr()
	-- local buffer = fn.bufnr("%")

	for _, command in pairs(run) do
		-- tapped together solution, but works! :)
		cmd([[windo let w:tz_buffer = bufnr("%") | bufdo ]] .. command .. [[  | exe "buffer " . w:tz_buffer]])
	end

	w.tz_buffer = nil

	cmd("tabn " .. tab)
	cmd(winnr .. " wincmd w")
	-- cmd("buffer " .. buffer)
end

local function save_opts()
	original_opts.ruler = o.ruler
	original_opts.laststatus = o.laststatus
	original_opts.showcmd = o.showcmd
	original_opts.showmode = o.showmode
	original_opts.number = o.number
	original_opts.relativenumber = o.relativenumber
	original_opts.showtabline = o.showtabline
	original_opts.statusline = o.statusline
	original_opts.cmdheight = o.cmdheight
	original_opts.highlights = {
		StatusLine = colors.get_hl("StatusLine"),
		StatusLineNC = colors.get_hl("StatusLineNC"),
	}
end

function M.on()
	save_opts()

	o.ruler = false
	o.laststatus = 0
	o.showcmd = false
	o.showmode = false
	o.number = false
	o.relativenumber = false
	o.showtabline = 0
	o.statusline = ""
	o.cmdheight = 1

	-- hide (relative)number on every window or every tab
	alldo({ "set norelativenumber", "set nonumber" })

	-- hide statusline
	local bkg_color = colors.get_hl("Normal")["background"] or "NONE"
	colors.highlight("StatusLine", { fg = bkg_color, bg = bkg_color }, true)
	colors.highlight("StatusLineNC", { fg = bkg_color, bg = bkg_color }, true)

	is_minimalized = true
end

function M.off()
	for k,v in pairs(original_opts) do
		if k ~= "highlights" then
			o[k] = v
		end
	end

	if original_opts.number then
		alldo({ "set number" })
	end

	if original_opts.relativenumber then
		alldo({ "set relativenumber" })
	end

	for hi_group,props in pairs(original_opts["highlights"]) do
		colors.highlight(hi_group, { fg = props.foreground, bg = props.background }, true)
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
