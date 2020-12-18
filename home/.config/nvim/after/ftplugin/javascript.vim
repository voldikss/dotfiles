setlocal foldmethod=indent
setlocal tabstop=2
setlocal shiftwidth=2
setlocal commentstring=//\ %s
setlocal nospell

" html match_words
if !exists('b:match_words')
  let b:match_words = ''
else
  let b:match_words .= ','
endif
let b:match_words .= '<:>,<\@<=[ou]l\>[^>]*\%(>\|$\):<\@<=li\>:<\@<=/[ou]l>,<\@<=dl\>[^>]*\%(>\|$\):<\@<=d[td]\>:<\@<=/dl>,<\@<=\([^/][^ \t>]*\)[^>]*\%(>\|$\):<\@<=/\1>'
