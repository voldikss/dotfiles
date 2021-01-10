" ============================================================================
" FileName: command.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Some commands' functions
" ============================================================================

" OpenFileExplore:
function! fn#command#open_file_explorer() abort
  let path = expand(getcwd())
  call fn#util#system_open(path)
endfunction

" Grep:
function! fn#command#grep(string) abort
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
function! fn#command#tab_message(cmd) abort
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    call fn#util#show_msg('No Output', 'warning')
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction

" DelimiterLine:
function! fn#command#insert_line(style, ...) abort
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
function! fn#command#zeal(query) abort
  if empty(a:query)
    let query = expand('<cword>')
  else
    let query = a:query
  endif
  let cmd = printf("zeal '%s:%s' 2> /dev/null &", &ft, query)
  call jobstart(cmd)
endfunction

" WinDo: Like windo but restore the current window.
function! fn#command#windo(command)
  let curwin=winnr()
  execute 'windo ' . a:command
  execute curwin . 'wincmd w'
endfunction

" BufDo: Like bufdo but restore the current buffer.
function! fn#command#bufdo(command)
  let curbuf=bufnr("%")
  execute 'bufdo ' . a:command
  execute 'buffer ' . curbuf
endfunction

" TabDo: Like tabdo but restore the current tab.
function! fn#command#tabdo(command)
  let curtab=tabpagenr()
  execute 'tabdo ' . a:command
  execute 'tabn ' . curtab
endfunction

" GwritePlus: Gwrite and reload buffer
" Because coc-git recently fails to update gutter after Gwrite...
function! fn#command#gwrite_plus() abort
  let save_view = winsaveview()
  Gwrite | e
  call winrestview(save_view)
endfunction
