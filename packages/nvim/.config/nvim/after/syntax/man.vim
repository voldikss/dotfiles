" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Custom man filetype syntax for easy reading
" ============================================================================

" -xxx
syntax match manExtraPattern1 '\s-\S\+'
hi def link manExtraPattern1 Keyword

" [xxx]
syntax match manExtraPattern2 '\[.\{-}\]'
hi def link manExtraPattern2 Define

" XX_XXX  NOTE: this will break syntax for `#include<xxx.h>`
" syntax match manExtraPattern3 '\(\u\|_\)\{2,}'
" hi def link manExtraPattern3 Identifier

" XXXX() function
syntax match manExtraPattern4 '\w[a-zA-Z0-9_]\+()'
hi def link manExtraPattern4 Function
