

" GPL-3.0 License

" prevent the plugin from loading twice
if exists('g:loaded_TrueZen') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" command! -nargs=* Sub call MapArgs(<f-args>) | lua require("t2").parse_and_categorize("hehe")
function! s:MapArgs(...)
	if (a:0 > 4)
		echom "TrueZen: you cannot pass more than 4 arguments to this command."
	else
		for i in a:000
			if (i =~ 't' || i =~ 'T')
				let g:tz_top_padding = substitute(i, 't', "", "")
			elseif (i =~ 'l' || i =~ 'L')
				let g:tz_left_padding = substitute(i, 'l', "", "")
			elseif (i =~ 'r' || i =~ 'R')
				let g:tz_right_padding = substitute(i, 'r', "", "")
			elseif (i =~ 'b' || i =~ 'B')
				let g:tz_bottom_padding = substitute(i, 'b', "", "")
			else
				echoerr "The prefix of '".i."' was not recognized."
			endif
		endfor
	endif
endfunction

" for verifying, use eval and exists("g:<var>").
" 1 = true
" 0 = false


" mapping {{{
" modes
" command! TZAtaraxis lua require'true-zen.main'.main(4, 0)
command! -nargs=* TZAtaraxis call s:MapArgs(<f-args>) | lua require'true-zen.main'.main(4, 0)
command! TZMinimalist lua require'true-zen.main'.main(3, 0)
command! TZFocus lua require'true-zen.main'.main(5, 0)

" general options
command! TZBottom lua require'true-zen.main'.main(0, 0)
command! TZTop lua require'true-zen.main'.main(1, 0)
command! TZLeft lua require'true-zen.main'.main(2, 0)
" }}}

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

" set to true the var that controls the plugin's loading
let g:loaded_TrueZen = 1
