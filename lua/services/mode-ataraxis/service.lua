

local cmd_settings = require("utils.cmd_settings")
local mode_minimalist = require("services.mode-minimalist.init")
local cmd = vim.cmd


function ataraxis_true()		-- show
	mode_minimalist.main(1)
end

function ataraxis_false()		-- don't show
	-- padding
	local padding_cmd = "vertical resize "..cmd_settings.map_settings["ataraxis"]["left_right_padding"]..""

	cmd("leftabove vnew")
	cmd(padding_cmd)
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	cmd("wincmd l")
	cmd("vnew")
	cmd("setlocal buftype=nofile bufhidden=wipe nomodifiable nobuflisted noswapfile nocursorline nocursorcolumn nonumber norelativenumber noruler noshowmode noshowcmd laststatus=0")
	cmd("wincmd h")
	mode_minimalist.main(2)
end



return {
	ataraxis_true = ataraxis_true,
	ataraxis_false = ataraxis_false
}
