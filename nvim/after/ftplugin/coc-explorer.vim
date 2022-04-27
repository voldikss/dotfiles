" ============================================================================
" FileName: coc-explorer.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" set nonumber
" set relativenumber

" refresh while entering
autocmd BufEnter,FocusGained <buffer> call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])

map <buffer> <2-LeftMouse> l
map <buffer> <3-LeftMouse> <CR>
map <buffer> <RightMouse> h
map <buffer> <2-RightMouse> <BS>

map <buffer> <MiddleMouse> <BS>

" preview
map <buffer><nowait> <Space> <P>
