" ============================================================================
" FileName: nvimgdb.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

syntax match GdbPrompt      /^\zs(gdb)\ze/ contained
syntax match GdbCommand     /^(gdb).*/     contains=GdbPrompt
syntax match GdbLineNr      /^\d\{1,5}/

hi GdbPrompt      guifg=#00afff              gui=bold
hi GdbCommand     guifg=lightmagenta         gui=italic
hi GdbLineNr      guifg=lightgrey
