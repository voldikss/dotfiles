" Jump to links with enter
nmap <buffer> <CR> <C-]>

" Jump back with backspace
nmap <buffer> <BS> <C-T>
" q to quit
nmap <buffer> q :quit<CR>
" open help file in the left window
" alternative: e.g. vert help syntax
autocmd BufWinEnter <buffer> wincmd H

setlocal number
