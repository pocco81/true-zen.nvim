local cmd = vim.cmd
local g = vim.g
local api = vim.api

function set_hi_groups(custome_bg, affected_higroups)
    custome_bg = custome_bg or ""
    affected_higroups =
        affected_higroups or
        {"NonText", "FoldColumn", "ColorColumn", "VertSplit", "StatusLine", "StatusLineNC", "SignColumn"}

    local concatenated_affected_higroups = "{"
    for grp, _ in pairs(affected_higroups) do
        concatenated_affected_higroups = concatenated_affected_higroups .. "'" .. grp .. "',"
    end
    concatenated_affected_higroups = concatenated_affected_higroups .. "}"

    g.__truezen_viml_affected_higroup = api.nvim_eval([[luaeval("]] .. concatenated_affected_higroups .. [[")]])

    vim.api.nvim_exec(
        [[
		function! GetColor(group, attr)
			return synIDattr(synIDtrans(hlID(a:group)), a:attr)
		endfunction
		com! -nargs=+ -complete=command GetColor call GetColor(<q-args>)

	]],
        false
    )

    vim.api.nvim_exec(
        [[
		function! SetColor(group, attr, color)
			let gui = has('gui_running') || has('termguicolors') && &termguicolors
			execute printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
		endfunction
		com! -nargs=+ -complete=command SetColor call SetColor(<q-args>)
	]],
        false
    )

    vim.api.nvim_exec(
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

    if (custome_bg == "" or custome_bg == "" or custome_bg == nil) then
        call_tran = "call Tranquilize('black', g:__truezen_viml_affected_higroup)"
    else
        call_tran = "call Tranquilize('" .. custome_bg .. "', g:__truezen_viml_affected_higroup)"
    end

    cmd(call_tran)
end

function store_hi_groups(local_hi_groups)
    local_hi_groups =
        local_hi_groups or
        {
            NonText = {},
            FoldColumn = {},
            ColorColumn = {},
            VertSplit = {},
            StatusLine = {},
            StatusLineNC = {},
            SignColumn = {}
        }

    hi_groups = local_hi_groups

    vim.api.nvim_exec(
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

    -- term != terminal; term = terminology
    terms = {
        "cterm",
        "ctermbg",
        "ctermfg",
        "guibg",
        "guifg",
        "gui"
    }

    for hi_index, _ in pairs(hi_groups) do
        for term_index, _ in pairs(terms) do
            cmd("let term_val = ReturnHighlightTerm('" .. hi_index .. "', '" .. terms[term_index] .. "')")
            local term_val = vim.api.nvim_eval("g:term_val")
            if (term_val == "" or term_val == "") then
                term_val = "NONE"
            end

            table.insert(hi_groups[hi_index], term_val)
        end
    end

    hi_groups_stored = true
end

function restore_hi_groups()
    if (hi_groups_stored == false or hi_groups_stored == nil) then
    elseif (hi_groups_stored == true) then
        for hi_index, _ in pairs(hi_groups) do
            local final_cmd = "highlight " .. tostring(hi_index) .. ""
            local list_of_terms = ""
            for inner_hi_index, _ in pairs(hi_groups[hi_index]) do
				print("inner hi index = "..inner_hi_index)
				print("term = "..terms[inner_hi_index])
                current_term = terms[inner_hi_index]
				-- print("Term = "..tostring(terms[inner_hi_index]))
                list_of_terms =
                    list_of_terms .. " " .. tostring(current_term) .. "=" .. tostring(hi_groups[hi_index][inner_hi_index]) .. ""
            end

            final_cmd = final_cmd .. list_of_terms
            cmd(final_cmd)
        end
    end
end

return {
    set_hi_groups = set_hi_groups,
    store_hi_groups = store_hi_groups,
    restore_hi_groups = restore_hi_groups
}
