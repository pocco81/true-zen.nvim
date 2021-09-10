local api = vim.api

--[[
escape backward slash
mental note: don't use simple quotation marks
call BufDo("set fillchars+=vert:\\ ")

since the function is global, it can be called outside of this nvim_exec statement like so:
vim.cmd([[call BufDo("set fillchars+=vert:\\ "
don't forget to complete the statement, is just becuase I can't do that within nvim_exec statement
]]
--

-- original source: https://vim.fandom.com/wiki/Run_a_command_in_multiple_buffers

-- like bufdo but restore the current buffer.
-- stylua: ignore
api.nvim_exec([[
	function! g:TrueZenBufDo(command)
		let currBuff=bufnr("%")
		execute 'bufdo ' . a:command
		execute 'buffer ' . currBuff
	endfunction
	com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)
]], false)

-- like windo but restore the current window
-- stylua: ignore
api.nvim_exec([[
	function! g:TrueZenWinDo(command)
		let currwin=winnr()
		execute 'windo ' . a:command
		execute currwin . 'wincmd w'
	endfunction
	com! -nargs=+ -complete=command Windo call WinDo(<q-args>)
]], false)

-- like tabdo but restore the current tab.
-- stylua: ignore
api.nvim_exec([[
	function! g:TrueZenTabDo(command)
		let currTab=tabpagenr()
		execute 'tabdo ' . a:command
		execute 'tabn ' . currTab
	endfunction
	com! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)
]], false)

-- like tabdo but restore the current tab.
-- stylua: ignore
api.nvim_exec([[
	function! g:TrueZenTabDo(command)
		let currTab=tabpagenr()
		execute 'tabdo ' . a:command
		execute 'tabn ' . currTab
	endfunction
	com! -nargs=+ -complete=command Tabdo call TabDo(<q-args>)
]], false)
