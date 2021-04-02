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

" NOTE: do not use `augroup` && `autocmd!` in the ftplugin/xxx.vim if already
" using `autocmd <buffer>`. Otherwise if I've opened mutltiple terminals,
" there would be only one autocmd for one terminal buffer (When opening a
" terminal, the previous terminal's autocmd would be deleted by `autocmd!`).
" Instead, use `autocmd! * <buffer>`
let b:enabled = v:true
augroup enter_intert_mode
  autocmd! * <buffer>
  autocmd BufEnter <buffer> if b:enabled | startinsert | endif
augroup END

augroup should_del_bufenter
  autocmd! * <buffer>
  autocmd BufLeave <buffer>
        \ if line('.') >= s:lastnonblank()   |
        \   let b:enabled = v:true           |
        \ else                               |
        \   let b:enabled = v:false          |
        \ endif
augroup END

function! s:lastnonblank() abort
  let lastlnum = line('$')
  while lastlnum > 0
    if empty(getline(lastlnum))
      let lastlnum -= 1
    else
      return lastlnum
    endif
  endwhile
  return lastlnum
endfunction

" @voldikss: quit without type Enter to confirm
" autocmd TermClose <buffer> call feedkeys("\<CR>")
