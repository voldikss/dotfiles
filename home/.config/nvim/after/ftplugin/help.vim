" Jump to links with enter
nmap <silent> <buffer> <CR> <C-]>

" Jump back with backspace
nmap <silent> <buffer> <BS> <C-T>
" q to quit
nmap <silent> <buffer> q :quit<CR>
" open help file in the left window
" alternative: e.g. vert help syntax
autocmd BufWinEnter <buffer> wincmd H

setlocal number
setlocal relativenumber
setlocal nospell
setlocal foldmethod=indent

setlocal textwidth=82
setlocal formatoptions+=t
setlocal formatoptions-=c
setlocal formatoptions-=r
setlocal formatoptions-=o
setlocal formatoptions-=q
