setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
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
