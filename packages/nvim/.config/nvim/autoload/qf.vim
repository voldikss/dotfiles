" ============================================================================
" FileName: qf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

autocmd BufEnter qf noa wincmd p | let s:prevwinid = win_getid() | noa wincmd p

let s:prevwinid = -1

" toggle qf(:copen)
function! qf#ctoggle() abort
  if &ft == 'qf'
    cclose
    call win_gotoid(s:prevwinid)
    return
  endif

  let s:prevwinid = win_getid()

  for winid in nvim_list_wins()
    if getbufvar(winbufnr(winid), '&filetype') == 'qf'
      cclose
      return
    endif
  endfor

  botright copen
endfunction

" toggle location(:lopen)
function! qf#ltoggle() abort
  if &ft == 'qf'
    lclose
    call win_gotoid(s:prevwinid)
    return
  endif

  let s:prevwinid = win_getid()

  for winid in nvim_list_wins()
    if getbufvar(winbufnr(winid), '&filetype') == 'qf'
      lclose
      return
    endif
  endfor

  if !empty(getloclist(win_getid()))
    botright lopen
  else
    call util#show_msg('No location list', 'warning')
  endif
endfunction
