" ============================================================================
" FileName: number.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! textobj#number#() abort
  call textobj#('\v\d+')
endfunction
