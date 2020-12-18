" ============================================================================
" FileName: api.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! fn#api#win_exists(winid) abort
  return !empty(getwininfo(a:winid))
endfunction

function! fn#api#win_execute(winid, cmd) abort
  let winid = win_getid()
  if winid == a:winid
    execute a:cmd
  else
    if win_gotoid(a:winid)
      execute a:cmd
      call win_gotoid(winid)
    endif
  endif
endfunction

function! fn#api#bufcount() abort
  return len(getbufinfo({'buflisted':1}))
endfunction
