" ============================================================================
" FileName: util.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Common functions
" ============================================================================

" SystemOpen:
function! util#external_open(obj) abort
  if empty(a:obj)
    let obj = fnameescape(expand('%:p'))
  else
    let obj = a:obj
  endif
  if has('win32') || has('win64') || has('win32unix')
    let cmd = 'rundll32 url.dll,FileProtocolHandler ' . obj
  elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
    let cmd = 'open ' . obj
  elseif executable('xdg-open')
    let cmd = 'xdg-open ' . obj
  else
    echoerr "Opener not found"
    return
  endif
  exec 'AsyncRun -silent' . ' ' . cmd
endfunction

" EchoMessage:
function! util#show_msg(content, ...) abort
  if a:0 == 0
    let msgtype = 'more'
  else
    let msgtype = a:1
  endif
  if msgtype == 'more'
    echohl MoreMsg
  elseif msgtype == 'warning'
    echohl WarningMsg
  elseif msgtype == 'error'
    echohl ErrorMsg
  endif
  if type(a:content) != 1
    let message = join(a:content, "\n")
  else
    let message = a:content
  endif
  echom message
  echohl None
  call timer_start(1000, {-> execute('echo', '')})
endfunction

" GetVisualSelect:
function! util#get_selected_text(visualmode, range, line1, line2) abort
  if a:range == 0
    let lines = [getline('.')]
  elseif a:range == 1
    let lines = [getline(a:line1)]
  else
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    if lnum1 == 0 || col1 == 0 || lnum2 == 0 || col2 == 0
      let lines = getline(a:line1, a:line2)
    else
      let lines = getline(lnum1, lnum2)
      if !empty(lines)
        if a:visualmode ==# 'v' || a:visualmode ==# 'V'
          let lines[-1] = lines[-1][: col2 - (&selection == 'inclusive' ? 1 : 2)]
          let lines[0] = lines[0][col1 - 1:]
        elseif a:visualmode == "\<c-v>"
          let i = 0
          for line in lines
            let lines[i] = line[col1 - 1: col2 - (&selection == 'inclusive' ? 1 : 2)]
            let i = i + 1
          endfor
        endif
      endif
    endif
  endif
  return lines
endfunction

function! util#win_exists(winid) abort
  return !empty(getwininfo(a:winid))
endfunction

function! util#win_execute(winid, cmd) abort
  let winid = win_getid()
  if winid == a:winid
    execute a:cmd
  else
    if win_gotoid(a:winid)
      execute a:cmd
      call win_gotoid(winid)
    endif
  endif
endfunction

function! util#bufcount() abort
  return len(getbufinfo({'buflisted':1}))
endfunction
