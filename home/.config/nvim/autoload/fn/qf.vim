" ============================================================================
" FileName: qf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! fn#qf#toggle() abort
  for winid in nvim_list_wins()
    if getbufvar(winbufnr(winid), '&filetype') == 'qf'
      cclose
      return
    endif
  endfor
  copen
endfunction
