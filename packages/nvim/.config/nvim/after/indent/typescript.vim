" Do not use `runtime!`
runtime indent/typescript.vim

if !exists('*GetTypescriptIndent')
  echoerr 'Should load [non-after/]indent/typescript.vim first'
  finish
endif

setlocal indentexpr=MyGetTypescriptIndent()

" A lot of patches...
function! MyGetTypescriptIndent() abort
  let prevlnum = prevnonblank(v:lnum)
  let prevline = getline(prevlnum)
  if prevline =~# '\v^\s*if.*return$'
    return indent(prevlnum)
  elseif getline(v:lnum - 2) =~# '\v^\s*if.*return$'
    if prevline =~# '{\s*$'
      return indent(prevlnum) + &shiftwidth
    else
      return indent(prevlnum)
    endif
  elseif prevline =~# '\v^\s*(const|let|var).*\)$'
    return indent(prevlnum)
  else
    return GetTypescriptIndent()
  endif
endfunction
