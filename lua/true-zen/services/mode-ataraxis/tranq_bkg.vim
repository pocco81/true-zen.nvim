
function! s:get_color(group, attr)
	return synIDattr(synIDtrans(hlID(a:group)), a:attr)
endfunction

function! s:set_color(group, attr, color)
	let gui = has('gui_running') || has('termguicolors') && &termguicolors
	execute printf('hi %s %s%s=%s', a:group, gui ? 'gui' : 'cterm', a:attr, a:color)
endfunction



function! s:tranquilize()
	let bg = s:get_color('Normal', 'bg#')
	for grp in ['NonText', 'FoldColumn', 'ColorColumn', 'VertSplit',
			\ 'StatusLine', 'StatusLineNC', 'SignColumn']
		" -1 on Vim / '' on GVim
		if bg == -1 || empty(bg)
			call s:set_color(grp, 'fg', 'black')
			call s:set_color(grp, 'bg', 'NONE')
		else
			call s:set_color(grp, 'fg', bg)
			call s:set_color(grp, 'bg', bg)
		endif

		call s:set_color(grp, '', 'NONE')
	endfor
endfunction


call s:tranquilize()
