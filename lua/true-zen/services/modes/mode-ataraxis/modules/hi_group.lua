local cmd = vim.cmd
local g = vim.g
local api = vim.api

local M = {}

local hi_groups
local default_higroups = {
	FoldColumn = true,
	ColorColumn = true,
	VertSplit = true,
	StatusLine = true,
	StatusLineNC = true,
	SignColumn = true,
}

-- term != terminal; term = terminology
local terms = {
	"cterm",
	"ctermbg",
	"ctermfg",
	"guibg",
	"guifg",
	"gui",
}

local function set_hgs(hg)
	hi_groups = hg
end

local function get_hgs()
	return hi_groups
end

function M.set_hi_groups(custom_bg)
	local hgs = get_hgs()

	local concatenated_affected_higroups = "{"
	for grp, _ in pairs(hgs) do
		concatenated_affected_higroups = concatenated_affected_higroups .. "'" .. grp .. "',"
	end
	concatenated_affected_higroups = concatenated_affected_higroups .. "}"

	g.__truezen_viml_affected_higroup = api.nvim_eval([[luaeval("]] .. concatenated_affected_higroups .. [[")]])

	api.nvim_exec(
		[[
		function! GetColor(group, attr)
			return synIDattr(synIDtrans(hlID(a:group)), a:attr)
		endfunction
		com! -nargs=+ -complete=command GetColor call GetColor(<q-args>)
	]],
		false
	)

	api.nvim_exec(
		[[
		function! SetColor(group, attr, color)
			let gui = has('gui_running') || has('termguicolors') && &termguicolors
			execute printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
		endfunction
		com! -nargs=+ -complete=command SetColor call SetColor(<q-args>)
	]],
		false
	)

	api.nvim_exec(
		[[
		function! Tranquilize(bg_color, hi_groups)
			let bg = GetColor('Normal', 'bg#')
			for grp in a:hi_groups
				" -1 on Vim / '' on GVim
				if bg == -1 || empty(bg)
					call SetColor(grp, 'fg', a:bg_color)
					call SetColor(grp, 'bg', 'NONE')
				else
					call SetColor(grp, 'fg', bg)
					call SetColor(grp, 'bg', bg)
				endif
				call SetColor(grp, '', 'NONE')
			endfor
		endfunction
	]],
		false
	)

	local call_tran = ""

	if custom_bg == "" or custom_bg == "" or custom_bg == nil then
		call_tran = "call Tranquilize('black', g:__truezen_viml_affected_higroup)"
	else
		call_tran = "call Tranquilize('" .. custom_bg .. "', g:__truezen_viml_affected_higroup)"
	end

	cmd(call_tran)
end

function M.store_hi_groups(user_hi_groups)
	user_hi_groups = user_hi_groups or default_higroups

	api.nvim_exec(
		[[
		function! ReturnHighlightTerm(group, term)
			" Store output of group to variable
			let output = execute('hi ' . a:group)
			" Find the term we're looking for
			return matchstr(output, a:term.'=\zs\S*')
		endfunction
	]],
		false
	)

	local hgs = {}
	for group, val in pairs(user_hi_groups) do
		if val == true then
			hgs[group] = {}
		end
	end

	for grp, _ in pairs(hgs) do
		for i = 1, #terms, 1 do
			cmd("let term_val = ReturnHighlightTerm('" .. grp .. "', '" .. terms[i] .. "')")
			local term_val = api.nvim_eval("g:term_val")
			if term_val == "" or term_val == "" then
				term_val = "NONE"
			end
			table.insert(hgs[tostring(grp)], term_val)
		end
	end

	set_hgs(hgs)
end

function M.restore_hi_groups()
	local hgs = get_hgs()
	if hgs ~= nil then
		for grp, teminology in pairs(hgs) do
			local list_of_terms = ""

			for i = 1, #terms, 1 do
				list_of_terms = list_of_terms .. " " .. terms[i] .. "=" .. teminology[i]
			end
			local final_cmd = "highlight " .. grp .. " " .. list_of_terms
			cmd(final_cmd)
		end
	end
	set_hgs(nil)
end

return M
