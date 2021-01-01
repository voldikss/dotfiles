" ============================================================================
" FileName: tex.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! s:tex_settings(...) abort
  setlocal shiftwidth=2
  setlocal nospell
  setlocal conceallevel=0
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
endfunction

