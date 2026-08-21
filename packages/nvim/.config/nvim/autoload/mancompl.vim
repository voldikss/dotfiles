" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description:
"   Redefine man#complete function in $VIMRUNTIME/autoload/man.vim
" ============================================================================

let s:cache = []

function! mancompl#complete(ArgLead, CmdLine, CursorPos)
  if empty(s:cache)
    let pages = systemlist('man -k .')
    call map(pages, {_,v -> s:handler(v)})
    let s:cache = sort(pages)
  endif

  return filter(copy(s:cache), 'stridx(v:val, a:ArgLead) == 0')
endfunction

function! s:handler(item) abort
  let group = matchlist(a:item, '^\(\S\+\)\s\((\S\+)\).*')
  return group[1] . group[2]
endfunction
