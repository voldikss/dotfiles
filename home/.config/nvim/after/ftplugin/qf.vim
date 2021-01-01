" ============================================================================
" FileName: qf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! s:settings() abort
  setlocal wrap
  setlocal norelativenumber number
  setlocal linebreak
  setlocal nolist
  setlocal cursorline
  setlocal nobuflisted
  setlocal nospell
  setlocal modifiable

  nnoremap <buffer> o    <CR><C-w>p

  " quit vim if the last window is qf
  autocmd BufEnter <buffer> if winnr('$') < 2| q | endif

  let b:undo_ftplugin = 'setl fo< com< ofu<'

  let b:qf_isLoc = ! empty(getloclist(0))
  if b:qf_isLoc == 1
    nnoremap <buffer> O <CR>:lclose<CR>
  else
    nnoremap <buffer> O <CR>:cclose<CR>
  endif
endfunction

call timer_start(100, { -> s:settings() })
