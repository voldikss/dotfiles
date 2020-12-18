" Vim indent file
" Language:    gdb(vim indent file for gdbinit file)
" Maintainer:  voldikss <dyzplus@gmail.com>
" Created:     2020-10-16
" Last Change: 2020-10-16

if exists("b:did_indent")
  finish
endif

let b:did_indent = 1
let b:current_indent = 'gdb'

setlocal indentexpr=GetGdbIndent()

if exists('*GetGdbIndent')
  finish
endif

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

function! GetGdbIndent() abort
  if v:lnum == 0
    return 0
  endif
  let line = getline(v:lnum)
  let idnt = indent(v:lnum)

  let prevlnum = s:GetPrevNonCommentLnum(v:lnum)
  let prevline = getline(prevlnum)
  let previdnt = indent(prevlnum)
  if prevlnum == 0
    return 0
  endif

  if line =~ '^\s*\(define\|document\).*$'
    return previdnt
  elseif line =~ '^\s*\(else\)\s*$'
    if prevline !~ '^\s*\(if)\s.*$'
      return previdnt - &shiftwidth
    else
      return previdnt
    endif
  elseif line =~ '^\s*\(end\).*$'
    if prevline !~ '^\s*\(define\|document\|if\|else\|while\).*$'
      return previdnt - &shiftwidth
    else
      return previdnt
    endif
  endif

  if prevline =~ '^\s*\(define\|document\|if\|else\|while\).*$'
    return &shiftwidth + previdnt
  else
    return previdnt
  endif
endfunction
