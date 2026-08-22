" ============================================================================
" FileName: terminal.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

setlocal undolevels=100
setlocal nobuflisted
setlocal nospell
setlocal modifiable

setlocal signcolumn=no
setlocal winfixwidth
setlocal winfixheight

function! s:asyncrun_settings() abort
  if !exists('b:asyncrun_cmd') | return | endif
  setlocal number
endfunction
call timer_start(10, { -> s:asyncrun_settings() })

nnoremap <silent><buffer> q :q<CR>

" @voldikss: quit without type Enter to confirm
" autocmd TermClose <buffer> call feedkeys("\<CR>")
