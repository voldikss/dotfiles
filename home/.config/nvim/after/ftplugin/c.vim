" ============================================================================
" FileName: c.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent
setlocal commentstring=//\ %s
setlocal nospell

if !exists('b:match_words')
  let b:match_words = ''
else
  let b:match_words .= ','
endif
let b:match_words .= '\<if\>:\<else\>,'
let b:match_words .= '\<switch\>:\<case\>:\<default\>,'
