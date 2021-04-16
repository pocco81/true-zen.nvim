

" preven the plugin from loading twice
if exists('g:loaded_TrueZen') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" mapping {{{
command! TZStatusline lua require'TrueZen'.main(0, 0)
command! TZStatuslineT lua require'TrueZen'.main(0, 1)
command! TZStatuslineF lua require'TrueZen'.main(0, 2)
" }}}

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

" set to true the var that controls the plugin's loading
let g:loaded_TrueZen = 1