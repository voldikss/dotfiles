" ============================================================================
" FileName: floaterm.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! myfloaterm#exec(visualmode, range, line1, line2, fargs) abort
  let [cmd, config] = floaterm#cmdline#parse(a:fargs)

  if empty(cmd)
    let lines = util#get_selected_text(a:visualmode, a:range, a:line1, a:line2)
    if empty(lines)
      return
    endif
    let cmd = lines[0]
  endif
  if empty(cmd)
    return
  endif

  let g:floaterm_exec_status = 'floaterm:running'
  call floaterm#new(0, cmd, {
        \ 'on_stdout': function('s:watch_callback'),
        \ 'on_stderr': function('s:watch_callback'),
        \ 'on_exit': function('s:watch_callback')
        \ }, config)
endfunction

function! s:watch_callback(job, data, event, ...) abort
  if a:event == 'stdout'
    if match(a:data, 'error') > -1
      let g:floaterm_exec_status = 'floaterm:error'
    else
      let g:floaterm_exec_status = 'floaterm:running'
    endif
  elseif a:event == 'stderr'
    let g:floaterm_exec_status = 'floaterm:failed'
    call timer_start(5000, {-> s:reset_floaterm_exec_status()})
  else
    let g:floaterm_exec_status = 'floaterm:finished'
    call timer_start(5000, {-> s:reset_floaterm_exec_status()})
  endif
endfunction

function! s:reset_floaterm_exec_status() abort
  let g:floaterm_exec_status = ''
endfunction
