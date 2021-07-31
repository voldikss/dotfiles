setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal nomodeline
setlocal formatoptions+=tl
setlocal textwidth=78
iabbrev <buffer> i I

setlocal spell
setlocal spelllang=en_us

" coc-pairs
let g:coc_pairs = [
  \['（', '）'],
  \['“', '”'],
  \['‘', '’'],
  \['《', '》'],
  \['*', '*'],
  \]
