local api = vim.api

local M = {}

function M.quit(state)
	if (state == "start") then
        api.nvim_exec([[
			augroup exit_ataraxis_too
				autocmd!
				autocmd QuitPre * only | let g:the_id = win_getid() | tabe % | call win_gotoid(g:the_id) | close | let g:ataraxis_was_quitted = "true" | execute "lua require('true-zen.services.mode-ataraxis.init').main(0)"
			augroup END
		]], false)
	else
        api.nvim_exec([[
			augroup exit_ataraxis_too
				autocmd!
			augroup END
		]], false)
	end
end

return M
