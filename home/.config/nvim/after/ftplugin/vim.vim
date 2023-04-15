setlocal tabstop=2
setlocal shiftwidth=2
setlocal softtabstop=2
setlocal commentstring=\"\ %s
setlocal foldmethod=indent
setlocal nospell

" For userfunc#keymap#Square_Brackets_Left and userfunc#keymap#Square_Brackets_Right
" solve conflicts with runtime/ftplugin/vim.vim line71
unmap <buffer> ]]
unmap <buffer> [[

" coc-pairs
let b:coc_pairs_disabled = ['"']

" vim-argwrap
let b:argwrap_line_prefix = '\ '
let b:argwrap_tail_indent_braces = '('

" override b:match_words for vim previously set in /usr/local/share/nvim/runtime/ftplugin/vim.vim
let b:match_words =
\ '\<fu\%[nction]\>:\<retu\%[rn]\>:\<endf\%[unction]\>,' .
\ '\<\(wh\%[ile]\|for\)\>:\<brea\%[k]\>:\<con\%[tinue]\>:\<end\(w\%[hile]\|fo\%[r]\)\>,' .
\ '\<if\>:\<el\%[seif]\>:\<endif\>,' .
\ '\<try\>:\<cat\%[ch]\>:\<fina\%[lly]\>:\<endt\%[ry]\>,' .
\ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>,'
