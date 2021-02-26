" ============================================================================
" FileName: command.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Some commands' functions
" ============================================================================

" OpenFileExplore:
function! command#open_file_explorer() abort
  let path = expand(getcwd())
  call util#external_open(path)
endfunction

" Grep:
function! command#grep(string) abort
  if executable('rg')
    execute "AsyncRun! rg -n " . a:string . " * "
    " execute "AsyncRun! -post=copen\ 8 rg -n " . a:string . " * "
  elseif has('win32') || has('win64')
    execute "AsyncRun! -cwd=<root> findstr /n /s /C:" . a:string
  else
    execute "AsyncRun! -cwd=<root> grep -n -s -R " .
      \ a:string . " * " .
      \ "--exclude='*.so' " .
      \ " --exclude='.git' " .
      \ "--exclude='.idea' " .
      \ "--exclude='.cache' " .
      \ "--exclude='.IntelliJIdea' " .
      \ "--exclude='*.py[co]'"
  endif
endfunction

" TabMessage:
function! command#tab_message(cmd) abort
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    call util#show_msg('No Output', 'warning')
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified winfixheight winfixwidth
    silent put=message
  endif
endfunction

" DelimiterLine:
function! command#insert_line(style, ...) abort
  if a:0 > 0
    let count = a:1
  else
    let count = 78
  endif
  let commenthead = &commentstring[:-4]
  if a:style == 'light'
    let line = commenthead . repeat('-', count - len(commenthead))
  elseif a:style == 'bold'
    let line = commenthead . repeat('=', count - len(commenthead))
  elseif a:style == 'comment'
    let line = repeat(&commentstring[0], count)
  endif
  call append(line('.'), line)
endfunction

" Zeal:
function! command#zeal(query) abort
  if empty(a:query)
    let query = expand('<cword>')
  else
    let query = a:query
  endif
  let cmd = printf("zeal '%s:%s' 2> /dev/null &", &ft, query)
  call jobstart(cmd)
endfunction

" Windo: Like windo but restore the current window.
function! command#windo(command)
  let sv_view = winsaveview()
  let curwin=winnr()
  execute 'windo ' . a:command
  execute curwin . 'wincmd w'
  call winrestview(sv_view)
endfunction

" Bufdo: Like bufdo but restore the current buffer.
function! command#bufdo(command)
  let sv_view = winsaveview()
  let curbuf=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . curbuf
  call winrestview(sv_view)
endfunction

" Tabdo: Like tabdo but restore the current tab.
function! command#tabdo(command)
  let sv_view = winsaveview()
  let curtab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . curtab
  call winrestview(sv_view)
endfunction

" ColorScheme: wrap colorscheme
function! command#colorscheme(theme) abort
  execute 'colorscheme ' a:theme
endfunction
function! command#colors(arg_lead, cmd_line, cursor_pos) abort
  let dir = fnamemodify('~/.config/nvim/colors', ':p')
  let candidates = map(readdir(dir), {_,f -> f[:-5]})
  if a:arg_lead == ''
    return candidates
  endif
  return filter(candidates, 'v:val[:len(a:arg_lead) - 1] == a:arg_lead')
endfunction
