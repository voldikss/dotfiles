" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: Custom man filetype syntax for easy reading
" ============================================================================

" -xxx
syntax match manExtraPattern1 '\s-\S\+'
" [xxx]
syntax match manExtraPattern2 '\[\zs.*\ze\]'
" XX_XXX
syntax match manExtraPattern3 '\<\(\u\|_\)\{2,}\>'

hi def link manExtraPattern1 Keyword
hi def link manExtraPattern2 Define
hi def link manExtraPattern3 Identifier
