print("i ran utils")

vim.api.nvim_exec(
    [[
	" Like bufdo but restore the current buffer.
	function! BufDo(command)
		let currBuff=bufnr("%")
		execute 'bufdo ' . a:command
		execute 'buffer ' . currBuff
	endfunction
	com! -nargs=+ -complete=command Bufdo call BufDo(<q-args>)

	" escape backward slash
	" mental note: don't use simple quotation marks
	" call BufDo("set fillchars+=vert:\\ ")

	" since the function is global, it can be called outside of this nvim_exec statement like so:
	" vim.cmd([[call BufDo("set fillchars+=vert:\\ "
	" don't forget to complete the statement, is just becuase I can't do that within nvim_exec statement
]],
    false
)
