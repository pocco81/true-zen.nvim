


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
		-- nothing'
		final_fillchars = fillchars
	else
		final_fillchars = fillchars:gsub( ": ", ":\\ ")
	end

	cmd("echo 'Fillchars = "..final_fillchars.."'")

	
end

function restore_fillchars()
	
end


return {
	set_fillchars = set_fillchars,
	store_fillchars = store_fillchars,
	restore_fillchars = restore_fillchars
}


