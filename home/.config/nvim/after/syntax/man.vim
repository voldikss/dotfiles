" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Custom man filetype syntax for easy reading
" ============================================================================

syntax match manExtraPattern1 '\s-\S\+'
syntax match manExtraPattern2 '\[\zs.*\ze\]'
syntax match manExtraPattern3 '\<\(\u\|_\)\+\>'
syntax match manExtraPattern4 '^\<\u\+\>'
hi def link manExtraPattern1 Keyword
hi def link manExtraPattern2 Define
hi def link manExtraPattern3 Identifier
hi def link manExtraPattern4 Constant
