" ============================================================================
" FileName: window.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" 0:up, 1:down, 2:pgup, 3:pgdown, 4:top, 5:bottom
function! fn#window#scroll_prev(mode, amount)
	if winnr('$') <= 1
		return
	endif
	noautocmd silent! wincmd p
	if a:mode == 0
		exec "normal! " . repeat("\<c-y>", a:amount)
	elseif a:mode == 1
		exec "normal! " . repeat("\<c-e>", a:amount)
	elseif a:mode == 2
		exec "normal! ".winheight('.')."\<c-y>"
	elseif a:mode == 3
		exec "normal! ".winheight('.')."\<c-e>"
	elseif a:mode == 4
		normal! gg
	elseif a:mode == 5
		normal! G
	elseif a:mode == 6
		exec "normal! \<c-u>"
	elseif a:mode == 7
		exec "normal! \<c-d>"
	elseif a:mode == 8
		exec "normal! k"
	elseif a:mode == 9
		exec "normal! j"
	endif
	noautocmd silent! wincmd p
endfunc

function! fn#window#scroll(direction) abort
  if translator#window#float#has_scroll()
    call translator#window#float#scroll(a:direction)
  elseif skylight#float#has_scroll()
    call skylight#float#scroll(a:direction, 3)
  elseif coc#float#has_scroll()
    call coc#float#scroll(a:direction, 3)
  else
    call fn#window#scroll_prev(a:direction, 3)
  endif
endfunction
