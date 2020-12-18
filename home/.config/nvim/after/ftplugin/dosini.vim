setlocal commentstring=#\ %s
" setlocal comments=:#

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

setlocal foldmethod=expr
setlocal foldexpr=IniFoldExpr(v:lnum)
