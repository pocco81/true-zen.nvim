

" GPL-3.0 License

" prevent the plugin from loading twice
if exists('g:loaded_TrueZen') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" mapping {{{
" modes
command! TZAtaraxis lua require'tz_main'.main(4, 0)
command! TZMinimalist lua require'tz_main'.main(3, 0)
command! TZFocus lua require'tz_main'.main(5, 0)

" general options
command! TZBottom lua require'tz_main'.main(0, 0)
command! TZTop lua require'tz_main'.main(1, 0)
command! TZLeft lua require'tz_main'.main(2, 0)
" }}}

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

" set to true the var that controls the plugin's loading
let g:loaded_TrueZen = 1
