setlocal tabstop=4
setlocal shiftwidth=4
setlocal softtabstop=4
setlocal foldmethod=indent
setlocal commentstring=#\ %s
setlocal nospell

let b:match_words = ''
let b:match_words .= '\<if\>:\<elif\>:\<else\>,'
let b:match_words .= '\<def\>:\<return\>,'
let b:match_words .= '\<def\>:\<yield\>,'
let b:match_words .= '\<try\>:\<except\>:\<finally\>,'

" For userfunc#keymap#Square_Brackets_Left and userfunc#keymap#Square_Brackets_Right
" solve conflicts with runtime/ftplugin/vim.vim line71
unmap <buffer> ]]
unmap <buffer> [[
