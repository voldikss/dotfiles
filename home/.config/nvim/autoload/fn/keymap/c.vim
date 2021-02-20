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
  if prevchar == '@' && a:key == '"'
    return a:key
  endif
  return fn#keymap#pairs_common(a:key, a:pairs, prevchar, nextchar)
endfunction

" Command: /
function! fn#keymap#c#Slash() abort
  if !has('unix')
    return "/"
  endif
  let pos = getcmdpos()
  let prechar = getcmdline()[pos-2]
  if prechar == '/' && pumvisible()
    return "\<Space>\<Left>"
  else
    return "/"
  endif
endfunction

" Command: \
function! fn#keymap#c#BackSlash() abort
  if !has('win32')
    return '\'
  endif
  let pos = getcmdpos()
  let prechar = getcmdline()[pos-2]
  if prechar == '\' && pumvisible()
    return "\<Space>\<Left>"
  else
    return '\'
  endif
endfunction

" Command: <C-f> smart jump forward
function! fn#keymap#c#CTRL_F() abort
  let delimiters = [' ', '/', '\', ':', '_', '#']
  let cmd = getcmdline()
  let pos = getcmdpos() - 2
  " if not found, jump to the beginning
  let dest = len(cmd) + 1
  " jump over continuous spaces
  if cmd[pos+2] == ' ' && cmd[pos+1] == ' '
    for idx in range(pos+2, len(cmd) + 1)
      if cmd[idx] != ' '
        let dest = idx + 1
        break
      endif
    endfor
  else
    for idx in range(pos+2, len(cmd) + 1)
      if index(delimiters, cmd[idx]) > -1
        let dest = idx + 1
        break
      endif
    endfor
  endif
  call setcmdpos(dest)
  return cmd
endfunction

" Command: <C-b> smart jump backward
function! fn#keymap#c#CTRL_B() abort
  let delimiters = [' ', '/', '\', ':', '_', '#']
  let cmd = getcmdline()
  let pos = getcmdpos() - 2
  " if not found, jump to the beginning
  let dest = 1
  " jump over continuous spaces
  if cmd[pos] == ' ' && cmd[pos-1] == ' '
    for idx in range(pos - 1, 1, -1)
      if cmd[idx] != ' '
        let dest = idx + 2
        break
      endif
    endfor
  else
    for idx in range(pos - 1, 1, -1)
      if index(delimiters, cmd[idx]) > -1
        let dest = idx + 2
        break
      endif
    endfor
  endif
  call setcmdpos(dest)
  return cmd
endfunction

" Command: <C-k> delete from cursor to the end
function! fn#keymap#c#CTRL_K()
  let cmd = getcmdline()
  let rem = strpart(cmd, getcmdpos() - 1)
  if ('' != rem)
    let @c = rem
  endif
  let l:ret = strpart(cmd, 0, getcmdpos() - 1)
  return l:ret
endfunction

" Command: <C-y> yank cmdline content
function! fn#keymap#c#CTRL_Y()
  let cmd = getcmdline()
  call setreg('"', cmd)
  if &clipboard == 'unnamed'
    call setreg('*', cmd)
  endif
  call feedkeys("\<Esc>", 'nt')
endfunction
