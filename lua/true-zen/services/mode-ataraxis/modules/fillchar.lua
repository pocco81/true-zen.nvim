


local cmd = vim.cmd



function set_fillchars()

	cmd([[set fillchars+=stl:\ ]])
	cmd([[set fillchars+=stlnc:\ ]])
	cmd([[set fillchars+=vert:\ ]])
	cmd([[set fillchars+=fold:\ ]])
	cmd([[set fillchars+=foldopen:\ ]])
	cmd([[set fillchars+=foldclose:\ ]])
	cmd([[set fillchars+=foldsep:\ ]])
	cmd([[set fillchars+=diff:\ ]])
	cmd([[set fillchars+=msgsep:\ ]])
	cmd([[set fillchars+=eob:\ ]])

end


function store_fillchars()

	local fillchars = vim.api.nvim_eval("&fillchars")

	if (fillchars == "" or fillchars == '' or fillchars == " " or fillchars == ' ' or fillchars == nil) then
		-- vim's default fillchars
		final_fillchars = [[stl:\ ,stlnc:\ ,vert:\│,fold:·,foldopen:-,foldclose:+,foldsep:\|,diff:-,msgsep:\ ,eob:~]]
	else
		fillchars_escaped_spaces = fillchars:gsub( ": ", ":\\ ")
		fillchars_escaped_thicc_pipes = fillchars_escaped_spaces:gsub(":│", [[:\│]])
		fillchars_escaped_thin_pipes = fillchars_escaped_thicc_pipes:gsub(":|", [[:\|]])
		final_fillchars = fillchars_escaped_thin_pipes
	end

	fillchars_stored = true
	
end

function restore_fillchars()

	if (fillchars_stored == true) then
		cmd("set fillchars="..final_fillchars.."")
	end
	
end



return {
	set_fillchars = set_fillchars,
	store_fillchars = store_fillchars,
	restore_fillchars = restore_fillchars
}


