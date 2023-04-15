" ============================================================================
" FileName: keymap.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! keymap#exec(cmd)
  execute a:cmd
  return ''
endfunction

" - key: input char
" - pairs: predefined pairs
" - prevchar: char before the cursor position
" - nextchar: char after the cursor position
function! keymap#pairs_common(key, pairs, prevchar, nextchar) abort
  if a:pairs[0] == a:pairs[1]
    if a:nextchar == a:pairs[1]
      return "\<Right>"
    else
      return a:pairs . "\<Left>"
    endif
  endif
  if a:key == a:pairs[0]
    if a:nextchar == ' ' || a:nextchar == '' || a:nextchar == a:pairs[1]
      return a:pairs . "\<Left>"
    else
      return a:key
    endif
  else
    if a:nextchar == a:key
      return "\<Right>"
    else
      return a:key
    endif
  endif
endfunction
