" ============================================================================
" FileName: file.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldik
" ============================================================================

" AutoFormat:
function! file#autoformat() abort
  if &readonly || !&modifiable
    return
  endif

  let curpos = getpos('.')
  " 1. remove whitespace
  call s:remove_white_spaces()
  " 2. remove blank line
  call s:remove_blank_lines()
  " 3. use coc
  silent! call CocAction('format')

  if expand('%') != ''
    update
  endif

  call setpos('.', curpos)
endfunction

" AutoSave:
function! file#update() abort
  if &readonly || !&modifiable || &bt == 'acwrite'
    return
  endif

  " let curpos = getpos('.')
  " if getpos('.')[1] != line('$')
  "   call s:remove_blank_lines()
  " endif

  " if !empty(trim(getline('.')))
  "   call s:remove_white_spaces()
  " endif

  if !empty(expand('%'))
    update
  endif

  " call setpos('.', curpos)
endfunction

" RemoveBlankLines:
function! s:remove_blank_lines() abort
  if !&modifiable
    return
  endif

  let save_reg = @"
  let endlnum = line('$')
  let lastnoblank = prevnonblank(endlnum)
  if endlnum == lastnoblank
    return
  endif
  execute printf('%s,%sdelete', lastnoblank+1, endlnum)
  let @" = save_reg
endfunction

" RemoveWhiteSpaces:
function! s:remove_white_spaces()
  if mode() ==# 'n'
    silent! keeppatterns keepjumps execute 'undojoin | %s/[ \t]\+$//g'
  endif
endfunction

" RenameFile:
function! file#rename() abort
  let old = expand('%')
  let new = input('New file name: ', expand('%'), 'file')
  if new != '' && new != old
    execute ':saveas ' new
    if has('unix')
      execute 'silent !rm ' old
    else
      execute 'silent !del ' old
    endif
    execute 'bdelete ' old
    redraw!
  endif
endfunction

" RemoveFile: remove current file
function! file#remove() abort
  let fname = expand('%')
  execute 'bdelete ' fname
  if has('unix')
    execute 'silent !rm ' fname
  else
    execute 'silent !del ' fname
  endif
  redraw!
endfunction

" Refresh:
function! file#refresh() abort
  if &readonly || !&modifiable || bufname() == ''
    return
  endif
  let save_view = winsaveview()
  update
  edit
  call winrestview(save_view)
endfunction
