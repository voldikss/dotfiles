" ============================================================================
" FileName: mark.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let g:mark_case_sensitive = get(g:, 'mark_case_sensitive', 0)

nnoremap <silent> <Plug>MarkSet   :call mark#do('n')<CR>
vnoremap <silent> <Plug>MarkSet   :call mark#do('v')<CR>
nnoremap <silent> <Plug>MarkClear :call mark#uncolor_all()<CR>
nnoremap <silent> <Plug>MarkNext  :call mark#jump(1)<CR>
nnoremap <silent> <Plug>MarkPrev  :call mark#jump(0)<CR>
