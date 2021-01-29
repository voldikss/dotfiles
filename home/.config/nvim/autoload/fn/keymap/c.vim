" ============================================================================
" FileName: c.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Command: <BS>
function! fn#keymap#c#BS() abort
  let pos = getcmdpos()
  let surround = getcmdline()[pos-2:pos-1]
  if index(["''", '<>', '()', '[]', '{}'], surround) >=0
    return "\<Right>\<BS>\<BS>"
  else
    return "\<BS>"
  endif
endfunction

" Command: ''|<>|()|[]|{}
function! fn#keymap#c#pairs(key, pairs) abort
  let pos = getcmdpos()
  let cmdline = getcmdline()
  let prevchar = cmdline[pos-2]
  let nextchar = cmdline[pos-1]
  if a:pairs[0] == a:pairs[1]
    if nextchar == a:pairs[1]
      return "\<Right>"
    else
      return a:pairs . "\<Left>"
    endif
  endif
  if a:key == a:pairs[0]
    if nextchar == ' ' || nextchar == '' || nextchar == a:pairs[1]
      return a:pairs . "\<Left>"
    else
      return a:key
    endif
  else
    if nextchar == a:key
      return "\<Right>" 
    else
      return a:key
    endif
  endif
endfunction

" Command: /
function! fn#keymap#c#Slash() abort
  let pos = getcmdpos()
  let prechar = getcmdline()[pos-2]
  if prechar == '/' && pumvisible()
    return "\<Space>\<Left>"
  else
    return "/"
  endif
endfunction
