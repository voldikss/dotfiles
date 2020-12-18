setlocal shiftwidth=2
setlocal nospell

" coc-pairs
let g:coc_pairs = [
  \['（', '）'],
  \['“', '”'],
  \['‘', '’'],
  \['《', '》'],
  \['*', '*'],
  \['$', '$'],
  \]

setlocal textwidth=82
setlocal formatoptions=jmBtl

let b:match_words = '\<begin\>:\<end\>'

" prevent from setting conceallevel to 2 in vimtex
function! s:settings(...) abort
  setlocal conceallevel=0
endfunction
call timer_start(200, function('s:settings'))
