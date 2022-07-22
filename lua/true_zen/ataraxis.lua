local M = {}

local running
local colors = require("true_zen.utils.colors")
local cmd = vim.cmd
local cnf = require("true_zen.config").options
local fn = vim.fn
local o = vim.o
local wo = vim.wo
local api = vim.api

local base = colors.get_hl("Normal")["background"]

if cnf.modes.ataraxis.backdrop ~= 0 then
	if cnf.modes.ataraxis.shade == "dark" then
		base = colors.darken("#000000", cnf.modes.ataraxis.backdrop, base)
	else
		base = colors.lighten( "#ffffff", cnf.modes.ataraxis.backdrop, base)
	end

	colors.highlight("TZBackground", { fg = base, bg = base }, true)
end

if cnf.modes.ataraxis.quit_untoggles == true then
	api.nvim_create_augroup("TrueZenAtaraxis", {
		clear = true
	})
end

local original_opts = {}
local opts = {
	bo = {
		buftype = "nofile",
		bufhidden = "hide",
		modifiable = false,
		buflisted = false,
		swapfile = false,
	},
	wo = {
		cursorline = false,
		cursorcolumn = false,
		number = false,
		relativenumber = false,
		foldenable = false,
	}
}

local function save_opts()
	original_opts.fillchars = o.fillchars
	original_opts.highlights = {
		MsgArea = colors.get_hl("MsgArea"),
		FoldColumn = colors.get_hl("FoldColumn"),
		ColorColumn = colors.get_hl("ColorColumn"),
		VertSplit = colors.get_hl("VertSplit"),
		SignColumn = colors.get_hl("SignColumn"),
	}
end

local function gen_win(new, resize, move)
	cmd(new)
	cmd(resize)

	wo.winhighlight = "Normal:TZBackground"

	for opt_type,_ in pairs(opts) do
		for opt, val in pairs(opts[opt_type]) do
			vim[opt_type][opt] = val
		end
	end

	cmd(move)
end

function M.on()
	if cnf.modes.ataraxis.quit_untoggles == true then
		api.nvim_create_autocmd({ "QuitPre" }, {
			callback = function ()
				M.off()
			end,
			group = "TrueZenAtaraxis"
		})
	end

	require("true_zen.minimalist").on()
	save_opts()

	if fn.filereadable(fn.expand("%:p")) == 1 then
		cmd("tabe %")
	end

	gen_win("leftabove vnew", "vertical resize " .. cnf.modes.ataraxis.padding.left, "wincmd l") -- left buffer
	gen_win("vnew", "vertical resize " .. cnf.modes.ataraxis.padding.right, "wincmd h") -- right buffer
	gen_win("leftabove new", "resize " .. cnf.modes.ataraxis.padding.top, "wincmd j") -- top buffer
	gen_win("rightbelow new", "resize " .. cnf.modes.ataraxis.padding.bottom, "wincmd k") -- bottom buffer

	o.fillchars = "stl: ,stlnc: ,vert: ,diff: ,msgsep: ,eob: "
	o.showtabline = 0

	for hi_group,_ in pairs(original_opts["highlights"]) do
		colors.highlight(hi_group, { bg = base })
	end

	running = true
end

function M.off()
	cmd("only")
	cmd("q")
	require("true_zen.minimalist").off()

	for k,v in pairs(original_opts) do
		if k ~= "highlights" then
			o[k] = v
		end
	end

	for hi_group,props in pairs(original_opts["highlights"]) do
		colors.highlight(hi_group, { fg = props.foreground, bg = props.background }, true)
	end

	if cnf.modes.ataraxis.quit_untoggles == true then
		api.nvim_create_augroup("TrueZenAtaraxis", {
			clear = true
		})
	end

	running = false
end

function M.toggle()
	if running then
		M.off()
	else
		M.on()
	end
end

return M
