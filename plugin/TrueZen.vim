

" preven the plugin from loading twice
if exists('g:loaded_TrueZen') | finish | endif

let s:save_cpo = &cpo " save user coptions
set cpo&vim " reset them to defaults

" mapping {{{
command! TZStatusline lua require'TrueZen'.toggle_statusline()
command! TZStatuslineT lua require'TrueZen'.statusline_true()
command! TZStatuslineF lua require'TrueZen'.statusline_false()
" }}}

let &cpo = s:save_cpo " and restore after
unlet s:save_cpo

" set to true the var that controls the plugin's loading
let g:loaded_TrueZen = 1
