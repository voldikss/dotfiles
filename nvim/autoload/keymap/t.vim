" ============================================================================
" FileName: t.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Terminal: ''|<>|()|[]|{}
function! keymap#t#pairs(key, pairs) abort
  " XXX: there is a bug of getting current cursor position in nvim's terminal
  " because when leaving terminal mode, the cursor position is changed!...
  " currently just return a:pairs until the bug gets fixed.
  return a:pairs . "\<Left>"
  let pos = col('.') " TODO: use charcol()
  let line = getline('.')
  let prevchar = strcharpart(line, pos-2, 1)
  let nextchar = strcharpart(line, pos-1, 1)
  echom pos
  echom line
  echom prevchar . ' ' . nextchar
  return keymap#pairs_common(a:key, a:pairs, prevchar, nextchar)
endfunction
