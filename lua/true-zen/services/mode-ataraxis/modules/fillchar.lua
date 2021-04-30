


local cmd = vim.cmd



function set_fillchars()
	cmd([[set fillchars+=vert:\ ]])
	cmd([[set fillchars+=stl:\ ]])
	cmd([[set fillchars+=stlnc:\ ]])
	cmd([[set fillchars+=eob:\ ]])
end


function store_fillchars()

	local fillchars = vim.api.nvim_eval("&fillchars")

	if (fillchars == "" or fillchars == '') then
		final_fillchars = fillchars
	else
		final_fillchars = fillchars:gsub( ": ", ":\\ ")
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


