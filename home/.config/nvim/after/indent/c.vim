" ============================================================================
" FileName: c.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: C's extra indent method
" ============================================================================

function! MyCIndent()
  let line = getline(v:lnum)
  " `case` should have the identical indent value with `switch`
  if line =~ 'case\s.\{-}:'
    let pos = getpos('.')
    call search('switch', 'beW')
    let switch_lnum = line('.')
    call setpos('.', pos)
    return indent(switch_lnum)
  endif

  let prevlnum = prevnonblank(v:lnum)
  let prevline = getline(prevlnum)
  " `case` should have the identical indent value with `switch`
  if prevline =~ 'switch\s('
    return indent(prevline)
  endif
  " Fix after `break;` indentation
  if prevline =~ '^\s\+break;'
    return indent(prevlnum) - &shiftwidth
  endif

  " Eventually
  return cindent(v:lnum)
endfunction
setlocal indentexpr=MyCIndent()
