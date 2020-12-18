" ============================================================================
" FileName: mark.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let g:mark_case_sensitive = get(g:, 'mark_case_sensitive', 0)

nnoremap <silent> <Plug>MarkSet   :call fn#mark#do('n')<CR>
vnoremap <silent> <Plug>MarkSet   :call fn#mark#do('v')<CR>
nnoremap <silent> <Plug>MarkClear :call fn#mark#uncolor_all()<CR>
nnoremap <silent> <Plug>MarkNext  :call fn#mark#jump(1)<CR>
nnoremap <silent> <Plug>MarkPrev  :call fn#mark#jump(0)<CR>
