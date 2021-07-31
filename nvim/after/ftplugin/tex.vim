" ============================================================================
" FileName: tex.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

setlocal shiftwidth=2
setlocal nospell
setlocal textwidth=82
setlocal formatoptions=jmBtl

" coc-pairs
let g:coc_pairs = [
      \['（', '）'],
      \['“', '”'],
      \['‘', '’'],
      \['《', '》'],
      \['*', '*'],
      \['$', '$'],
      \]

let b:match_words = '\<begin\>:\<end\>'

function! s:tex_settings() abort
  " vimtex.vim
  setlocal conceallevel=0
endfunction

call timer_start(100, {->s:tex_settings()})
