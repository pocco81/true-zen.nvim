


local cmd = vim.cmd


function store_hi_groups()

	vim.api.nvim_exec([[
		function! ReturnHighlightTerm(group, term)
			" Store output of group to variable
			let output = execute('hi ' . a:group)

			" Find the term we're looking for
			return matchstr(output, a:term.'=\zs\S*')
		endfunction
	]], false)

	hi_groups = {
		NonText = {},
		FoldColumn = {},
		ColorColumn= {},
		VertSplit = {},
		StatusLine = {},
		StatusLineNC = {},
		SignColumn = {}
	}

	-- term != terminal; term = terminology
	terms = {
		'cterm',
		'ctermbg',
		'ctermfg',
		'guibg',
		'guifg',
		'gui'
	}


	for hi_index, _ in pairs(hi_groups) do

		for term_index, _ in pairs(terms) do
			-- local to_call = "[[call ReturnHighlightTerm('"..hi_value.."', '"..term_value.."')]]"
			cmd("let term_val = ReturnHighlightTerm('"..hi_index.."', '"..terms[term_index].."')")
			local term_val = vim.api.nvim_eval("g:term_val")
			-- cmd("echo 'Val = "..term_val.."'")

			if (term_val == "" or term_val == '') then
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
		-- cmd("echo '<Space>'")
		for hi_index, _ in pairs(hi_groups) do
			-- cmd("echo 'Index = "..tostring(hi_index).."; Value = "..tostring(hi_value).."'")
			local final_cmd = "highlight "..tostring(hi_index)..""
			local list_of_terms = ""
			-- cmd("highlight StatusLine ctermfg=bg ctermbg=bg guibg=bg guifg=bg")
			for inner_hi_index, _ in pairs(hi_groups[hi_index]) do
				-- cmd("echo 'Index = "..tostring(inner_hi_index).."; Value = "..tostring(hi_groups[hi_index][inner_hi_index]).."'")
			
				-- we need to construct the cmd like so:
				current_term = terms[inner_hi_index]
				list_of_terms = list_of_terms.." "..current_term.."="..tostring(hi_groups[hi_index][inner_hi_index])..""

			end

			final_cmd = final_cmd..list_of_terms
			cmd(final_cmd)
		end

	end
	
end



return {
	store_hi_groups = store_hi_groups,
	restore_hi_groups = restore_hi_groups
}

