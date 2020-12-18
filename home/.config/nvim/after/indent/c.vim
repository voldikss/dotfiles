" ============================================================================
" FileName: c.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: C's extra indent method
" ============================================================================

function! CExtraIndent()
  let line = getline(v:lnum)
  let prevlnum = prevnonblank(v:lnum)
  let prevline = getline(prevlnum)

  " Fix after `break;` indentation
  if prevline =~ 'break;'
    return indent(prevlnum) - &shiftwidth
  else
    return cindent(v:lnum)
  endif
endfunction
setlocal indentexpr=CExtraIndent()
