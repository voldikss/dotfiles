" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss

" RunTask:
function! fn#task#run(...) abort
  update
  if g:asyncrun_status ==# 'running'
    AsyncStop
    sleep 500m  " wait job to stop
  endif
  if a:0 > 0
    let b:quickrun_cmd = a:1
  endif
  if exists('b:quickrun_cmd')
    " echom 'b:quickrun_cmd: ' . b:quickrun_cmd
    execute b:quickrun_cmd
    return
  elseif expand('%') == 'init.vim'
    source %
  elseif &filetype == 'tex'
    if b:vimtex.compiler.is_running()
      VimtexView
    else
      VimtexCompile
    endif
  else
    AsyncTask start
  endif
endfunction

function! fn#task#complete(arg_lead,cmd_line,cursor_pos) abort
  let lst = ['AsyncRun'] + getcompletion('', 'shellcmd')
  let cmd_line_before_cursor = a:cmd_line[:a:cursor_pos - 1]
  let args = split(cmd_line_before_cursor, '\v\\@<!(\\\\)*\zs\s+', 1)
  call remove(args, 0)

  if len(args) ==# 1
    if args[0] ==# ''
      return lst
    else
      let prefix = args[-1]
      let candidates = filter(lst, 'v:val[:len(prefix) - 1] ==# prefix')
      return candidates
    endif
  endif
endfunction

let s:run_on_save_change_enable = v:false
function! fn#task#run_on_save_change(local) abort
  if s:run_on_save_change_enable == v:true
    autocmd! run-task-on-save-change 
    let s:run_on_save_change_enable = v:false
  else
    augroup run-task-on-save-change
      autocmd!
      if a:local " buffer local
        autocmd BufWritePost <buffer> RunTask
      else
        autocmd BufWritePost * RunTask
      endif
    augroup END
    let s:run_on_save_change_enable = v:true
  endif
endfunction
