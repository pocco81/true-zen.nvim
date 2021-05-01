


local api = vim.api
local cmd = vim.cmd



function toggle_element(element)

	if (element == 0) then			-- current line blame
		cmd("Gitsigns toggle_current_line_blame")
	elseif (element == 1) then		-- numhl
		cmd("Gitsigns toggle_numhl")
	elseif (element == 2) then		-- linehl
		cmd("Gitsigns toggle_linehl")
	elseif (element == 3) then		-- signs
		cmd("Gitsigns toggle_signs")
	end

end



return {
	toggle_element = toggle_element,
}
