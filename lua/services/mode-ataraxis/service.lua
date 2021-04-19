

local opts = require("config").options
local mode_minimalist = require("services.mode-minimalist.init")
local cmd = vim.cmd


local function fillchars()
	cmd([[set fillchars+=vert:\ ]])
	cmd([[set fillchars+=stl:\ ]])
	cmd([[set fillchars+=stlnc:\ ]])
end

function ataraxis_true()		-- show

	cmd("wincmd h")
	cmd("q")
	cmd("wincmd l")
	cmd("q")
	mode_minimalist.main(1)
end

function ataraxis_false()		-- don't show

	-- padding
	-- local padding_cmd = "vertical resize "..cmd_settings.map_settings["ataraxis"]["left_right_padding"]..""
	local padding_cmd = "vertical resize "..opts["ataraxis"]["left_right_padding"]..""

	-- left buffer
	cmd("leftabove vnew")
	cmd(padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()

	-- middle buffer
	cmd("wincmd l")

	-- right buffer
	cmd("vnew")
	cmd(padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	fillchars()

	cmd([[bufdo set fillchars+=vert:\ ]])


	-- middle buffer
	cmd("wincmd h")
	fillchars()
	mode_minimalist.main(2)
end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
