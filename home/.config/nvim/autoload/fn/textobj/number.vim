" ============================================================================
" FileName: number.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! fn#textobj#number#() abort
  call fn#textobj#('\v\d+')
endfunction
