" ============================================================================
" FileName: coc-explorer.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" set nonumber
" set relativenumber

" refresh while entering
autocmd BufEnter,FocusGained <buffer> call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])
