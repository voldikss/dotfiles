" ============================================================================
" FileName: qf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

setlocal wrap
setlocal norelativenumber
setlocal number
setlocal linebreak
setlocal nolist
setlocal cursorline
setlocal nobuflisted
setlocal nospell

nnoremap <buffer> o    <CR><C-w>p

" quit vim if the last window is qf
autocmd BufEnter <buffer> if winnr('$') < 2| q | endif

let b:undo_ftplugin = 'setl fo< com< ofu<'

let b:qf_isLoc = ! empty(getloclist(0))
if b:qf_isLoc == 1
  nnoremap <silent><buffer> O <CR>:lclose<CR>
  nnoremap <silent><buffer> <Esc> :lclose<CR>
else
  nnoremap <silent><buffer> O <CR>:cclose<CR>
  nnoremap <silent><buffer> <Esc> :cclose<CR>
endif

function! s:settings() abort
  setlocal modifiable
endfunction
call timer_start(10, { -> s:settings() })
