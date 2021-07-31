" Vim indent file
" Language:    MySQL
" Maintainer:  voldikss <dyzplus@gmail.com>
" Created:     2020-03-24
" Last Change: 2020-03-24

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1
let b:current_indent = 'mysql'

setlocal indentexpr=GetMySqlIndent(v:lnum)

if exists('*GetMySqlIndent')
  finish
endif

let s:small_indentwidth = 2

function! s:GetPrevNonCommentLnum(lnum)
  let SKIP_LINES = '^\s*#.*'

  let nline = a:lnum
  while nline > 0
    let nline = prevnonblank(nline-1)
    if getline(nline) !~? SKIP_LINES
      break
    endif
  endwhile

  return nline
endfunction

function! GetMySqlIndent(lnum) abort
  if a:lnum == 0
    return 0
  endif
  let line = getline(a:lnum)
  let idnt = indent(a:lnum)

  let prevlnum = s:GetPrevNonCommentLnum(a:lnum)
  let prevline = getline(prevlnum)
  let previdnt = indent(prevlnum)
  if prevlnum == 0
    return 0
  endif

  if line =~ '\v^\s*#.*'
    return indent(a:lnum)
  elseif line =~ '\v;\s*#*.*$' " `;` at the end of line (with comment)
    return previdnt - s:small_indentwidth
  elseif line =~ '\v^\s*\).*$'
    return 0
  endif

  if prevline =~ '\v,(\s*#+.*)*$' " `,` at the end of line (with comment)
    return previdnt
  elseif prevline =~ 'foreign key\|begin'
    return previdnt + s:small_indentwidth
  elseif prevline =~ '\v\(\s*#+.*$' || prevline =~ '(\s*$'  " `(` at the end of line (with comment)
    return previdnt + s:small_indentwidth
  elseif prevline =~ 'values$'
    return previdnt + s:small_indentwidth
  else
    return 0
  endif
endfunction
