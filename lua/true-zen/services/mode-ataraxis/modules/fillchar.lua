


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

		cmd("echo 'I RAN'")
		final_fillchars = [[stl:\ ,stlnc:\ ,vert:\│,fold:·,foldopen:-,foldclose:+,foldsep:\|,diff:-,msgsep:\ ,eob:~]]
		-- final_fillchars = [[stl:\ ,stlnc:\ ,vert:\│]]
		cmd("echo 'Final thing = "..final_fillchars.."'")
	else
		final_fillchars = fillchars:gsub( ": ", ":\\ ")
		cmd("echo 'Final thing = "..final_fillchars.."'")
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


