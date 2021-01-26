" ============================================================================
" FileName: terminal.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

setlocal undolevels=100
setlocal signcolumn=no
setlocal nobuflisted
setlocal nospell
setlocal modifiable

if exists('b:asyncrun_cmd')
  setlocal number
endif

nmap <silent><buffer> q :q<CR>

" NOTE: do not use `augroup` && `autocmd!` in the ftplugin/xxx.vim if already
" using `autocmd <buffer>`. Otherwise if I've opened mutltiple terminals,
" there would be only one autocmd for one terminal buffer (When opening a
" terminal, the previous terminal's autocmd would be deleted by `autocmd!`).
autocmd BufEnter <buffer> startinsert
