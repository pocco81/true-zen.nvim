local M = {}

local echo = require("true_zen.utils.echo")
local cnf = require("true_zen.config").options
local cmd = vim.cmd
local fn = vim.fn
local wo = vim.wo
local b = vim.b
local o = vim.o

vim.g.active_buffs = 0
local original_buffer = {}

function M.pretty_folds()
	local v = vim.v
	local fold_count = v.foldend - v.foldstart + 1
	local prefix = "   " .. fold_count
	local separator = "   "
	return prefix .. separator .. fn.getline(v.foldstart)
end

local function save_buff_settings()
	original_buffer.foldenable = wo.foldenable
	original_buffer.foldmethod = wo.foldmethod
	original_buffer.foldminlines = wo.foldminlines
	original_buffer.foldtext = wo.foldtext
	original_buffer.fillchars = wo.fillchars
end

local function normalize_line(line, mode)
	local pline = (mode == "head" and vim.fn.foldclosed(line) or vim.fn.foldclosedend(line))
	return (pline > 0 and pline or line)
end

function M.on(line1, line2)
	local beg_line = normalize_line(line1, "head")
	local end_line = normalize_line(line2, "tail")
	local curr_pos = fn.getpos(".")

	echo(beg_line .. " : " .. end_line)

	if vim.g.active_buffs <= 0 then
		save_buff_settings()
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

	wo.foldtext = 'v:lua.require("true_zen.narrow").pretty_folds()'
	fn.setpos(".", curr_pos)
	cmd("normal! zz")

	if cnf.modes.narrow.run_ataraxis == true then
		if vim.g.active_buffs <= 0 then
			require("true_zen.ataraxis").on()
		end
	end

	wo.fillchars = (o.fillchars ~= "" and o.fillchars .. "," or "") .. "fold: "

	vim.g.active_buffs = vim.g.active_buffs + 1
end

function M.off()
	vim.g.active_buffs = (vim.g.active_buffs > 0 and vim.g.active_buffs or 1) - 1
	b.tz_narrowed_buffer = nil

	if cnf.modes.narrow.run_ataraxis == true then
		if vim.g.active_buffs <= 0 then
			require("true_zen.ataraxis").off()
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

	for k, v in pairs(original_buffer) do
		wo[k] = v
	end

	original_buffer = {}
end

function M.toggle(line1, line2)
	if b.tz_narrowed_buffer then
		M.off()
	else
		M.on(line1, line2)
	end
end

return M
