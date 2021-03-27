" Jump to links with enter
nnoremap <silent> <buffer> <CR> <C-]>

" Jump back with backspace
nnoremap <silent> <buffer> <BS> <C-T>

" open help file in the left window
" alternative: e.g. vert help syntax
autocmd BufWinEnter <buffer> wincmd H
" autocmd BufWinEnter <buffer> setlocal number

setlocal number
setlocal nospell
setlocal foldmethod=indent
if !&buflisted
  setlocal bufhidden=delete
endif

setlocal textwidth=82
setlocal formatoptions+=t
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=q

" textwidth + numberwidth + signcolumn width + 1 margin at the right of linenr column
call timer_start(10, {->execute('vertical resize ' . (&tw + &nuw + 2))})
