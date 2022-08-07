local M = {}

local echo = require("true-zen.utils.echo")
local cnf = require("true-zen.config").options
local colors = require("true-zen.utils.colors")
local data = require("true-zen.utils.data")
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn
local wo = vim.wo
local b = vim.b
local o = vim.o
local FOLDS_STYLE = cnf.modes.narrow.folds_style

vim.g.active_buffs = 0
local original_opts = {}

api.nvim_create_augroup("TrueZenNarrow", {
	clear = true,
})

function M.custom_folds_style()
	if type(FOLDS_STYLE) == "function" then
		return FOLDS_STYLE
	elseif FOLDS_STYLE == "informative" then
		local v = vim.v
		local fold_count = v.foldend - v.foldstart + 1
		local prefix = "   " .. fold_count
		local separator = "   "
		return prefix .. separator .. fn.getline(v.foldstart)
	end
	return ""
end

local function save_buff_settings()
	original_opts.foldenable = wo.foldenable
	original_opts.foldmethod = wo.foldmethod
	original_opts.foldminlines = wo.foldminlines
	original_opts.foldtext = wo.foldtext
	original_opts.fillchars = wo.fillchars
end

local function normalize_line(line, mode)
	local pline = (mode == "head" and vim.fn.foldclosed(line) or vim.fn.foldclosedend(line))
	return (pline > 0 and pline or line)
end

function M.on(line1, line2)
	data.do_callback("narrow", "open", "pre")

	local beg_line = normalize_line(line1, "head")
	local end_line = normalize_line(line2, "tail")
	local curr_pos = fn.getpos(".")

	if vim.g.active_buffs <= 0 then
		save_buff_settings()
	end

	if FOLDS_STYLE == "invisible" then
		local bkg_color = colors.get_hl("Normal")["background"] or "NONE"
		colors.highlight("Folded", { fg = bkg_color, bg = bkg_color }, true)
		original_opts.highlights = {
			Folded = colors.get_hl("Folded"),
		}
	end

	b.tz_narrowed_buffer = true
	wo.foldenable = true
	wo.foldmethod = "manual"
	wo.foldminlines = 0

	cmd("normal! zE")

	if beg_line > 1 then
		cmd([[execute '1,' (]] .. beg_line .. [[ - 1) 'fold']])
	end

	if end_line < fn.line("$") then
		cmd([[execute (]] .. end_line .. [[ + 1) ',$' 'fold']])
	end

	wo.foldtext = 'v:lua.require("true-zen.narrow").custom_folds_style()'
	fn.setpos(".", curr_pos)
	cmd("normal! zz")

	if cnf.modes.narrow.run_ataraxis == true then
		if cnf.modes.ataraxis.quit_untoggles == true then
			api.nvim_create_autocmd({ "QuitPre" }, {
				callback = function()
						M.off()
				end,
				group = "TrueZenNarrow",
			})
		end
		if vim.g.active_buffs <= 0 then
			require("true-zen.ataraxis").on()
		end
	end

	wo.fillchars = (o.fillchars ~= "" and o.fillchars .. "," or "") .. "fold: "

	vim.g.active_buffs = vim.g.active_buffs + 1
	data.do_callback("narrow", "open", "pos")
end

function M.off()
	data.do_callback("narrow", "close", "pre")

	vim.g.active_buffs = (vim.g.active_buffs > 0 and vim.g.active_buffs or 1) - 1
	b.tz_narrowed_buffer = nil

	if cnf.modes.narrow.run_ataraxis == true then
		if vim.g.active_buffs <= 0 then
			require("true-zen.ataraxis").off()
		end
	end

	local curr_pos = fn.getpos(".")

	if wo.foldmethod ~= "manual" then
		echo("'vim.wo.foldmethod' must be set to \"manual\"", "error")
	else
		cmd("normal! zE")
	end

	cmd("normal! zz")
	fn.setpos(".", curr_pos)

	for k, v in pairs(original_opts) do
		if k ~= "highlights" then
			o[k] = v
		end
	end

	if original_opts["highlights"] ~= nil then
		for hi_group, props in pairs(original_opts["highlights"]) do
			colors.highlight(hi_group, { fg = props.foreground, bg = props.background }, true)
		end
	end

	original_opts = {}
	data.do_callback("narrow", "close", "pos")
end

function M.toggle(line1, line2)
	if b.tz_narrowed_buffer then
		M.off()
	else
		M.on(line1, line2)
	end
end

return M
