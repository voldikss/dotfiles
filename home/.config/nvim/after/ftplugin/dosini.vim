" ============================================================================
" FileName: dosini.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! IniFoldExpr(lnum)
  let line = getline(a:lnum)

  if line =~# '^\s*\[[^]]*\]'
    return '>1'
  endif

  if line =~# '^#\s=*$'
    return 0
  endif

  return '='
endfunction

function! s:dosini_settings() abort
  setlocal commentstring=#\ %s
  setlocal comments=:#
  setlocal foldmethod=expr
  setlocal foldexpr=IniFoldExpr(v:lnum)
endfunction

call timer_start(100, { -> s:dosini_settings() })
