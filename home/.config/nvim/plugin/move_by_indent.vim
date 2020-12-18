" ============================================================================
" FileName: move_by_indent.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

"-----------------------------------------------------------------------------
" https://github.com/mg979/vim-mini-plugins/blob/master/plugin/move_by_indent.vim
"-----------------------------------------------------------------------------

" move by same indent
nnoremap <silent> [< :call <sid>move_by_indent(0,0)<CR>
nnoremap <silent> ]< :call <sid>move_by_indent(1,0)<CR>
xnoremap <silent> [< <esc>:call <sid>move_by_indent(0,0)<CR>m>gv
xnoremap <silent> ]< <esc>:call <sid>move_by_indent(1,0)<CR>m>gv

" move back to lesser indent
nnoremap <silent> [> :call <sid>move_by_indent(0,v:count1*-1)<CR>
xnoremap <silent> [> <esc>:call <sid>move_by_indent(0,-1)<CR>m>gv

" move forward to deeper indent
nnoremap <silent> ]> :call <sid>move_by_indent(1,v:count1)<CR>
xnoremap <silent> ]> <esc>:call <sid>move_by_indent(1,1)<CR>m>gv

" move back/forward to deeper indent
nnoremap <silent> [; :call <sid>move_by_indent(0,v:count1)<CR>
nnoremap <silent> ]; :call <sid>move_by_indent(1,v:count1)<CR>
xnoremap <silent> [; <esc>:call <sid>move_by_indent(0,1)<CR>m>gv
xnoremap <silent> ]; <esc>:call <sid>move_by_indent(1,1)<CR>m>gv

" move back/forward to lesser indent
nnoremap <silent> [, :call <sid>move_by_indent(0,v:count1*-1)<CR>
nnoremap <silent> ], :call <sid>move_by_indent(1,v:count1*-1)<CR>
xnoremap <silent> [, <esc>:call <sid>move_by_indent(0,-1)<CR>m>gv
xnoremap <silent> ], <esc>:call <sid>move_by_indent(1,-1)<CR>m>gv

"--------------------------------------------------------------

function! s:move_by_indent(forward, difference)
  "
  " Move by indentation level.
  "
  let indent = matchstr(getline('.'), '^\s*')
  let [ line, opts ] = a:forward ? [ '\%>', 'e' ] : [ '\%<', 'be' ]
  let line .= line('.') . 'l'
  if !a:difference
    let [met_different, met_empty, success] = [0, 0, 0]
    let [I, pos] = [indent(line('.')), getcurpos()]
    while ( a:forward ? line('.') < line('$') : line('.') > 1 )
      exe ( a:forward ? '+' : '-' )
      if getline('.') == ''
        let met_empty = 1
      elseif (met_different || met_empty) && I == indent(line('.'))
        let success = 1
        break
      elseif I != indent(line('.'))
        let met_different = 1
      endif
    endwhile
    if !success
      call setpos('.', pos)
    else
      normal! zv
    endif
  elseif a:difference > 0
    return search('^' . indent . line . '\s\+\S', opts)
  elseif (strlen(indent) - 1) > 0
    let indent = '\s\{,' . (strlen(indent) - 1) . '}'
    return search('^' . indent . line . '\S', opts)
  endif
endfunc
