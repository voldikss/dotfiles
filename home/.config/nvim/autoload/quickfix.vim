" ============================================================================
" FileName: qf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

autocmd BufEnter qf noa wincmd p | let s:prevwinid = win_getid() | noa wincmd p

let s:prevwinid = -1
function! quickfix#toggle() abort
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

  belowright copen
endfunction
