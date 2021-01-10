" ============================================================================
" FileName: n.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Normal: [[
function! fn#keymap#n#left_square_brackets() abort
  let curline = line('.')
  if empty(getline(curline-1))
    normal! {
  else
    normal! {
    if empty(getline('.'))
      normal! j
    endif
  endif
endfunction

" Normal: ]]
function! fn#keymap#n#right_square_brackets() abort
  let curline = line('.')
  if empty(getline(curline+1))
    normal! }
  else
    normal! }
    if empty(getline('.'))
      normal! k
    endif
  endif
endfunction

" Normal: <CR>
function! fn#keymap#n#CR() abort
  let line = trim(getline('.'))
  let disable_if_begin_with = ['#', '/']
  let disable_if_end_with = [',', ';', '{','[', '(', '/', '\', '<', '>']

  if line == '' || index(disable_if_begin_with, line[0]) >= 0 || index(disable_if_end_with, line[-1:]) >= 0
    return "\<CR>"
  endif

  if index(['c', 'cpp', 'cs', 'css', 'java', 'rust', 'scss', 'mysql'], &ft) >= 0
    return "A;"
  elseif index(['json', 'jsonc'], &ft) >= 0
    return "A,"
  elseif index(['qmake'], &ft) > 0
    return "A\\"
  else
    return "\<CR>"
  endif
endfunction

" Normal: q
function! fn#keymap#n#q() abort
  " is the last buffer
  if len(getbufinfo({'buflisted':1})) == 1 && winnr('$') == 1 && bufname() == ''
    return ":q!\<CR>"
  else
    return ":bp\<bar>vsp\<bar>bn\<bar>bd!\<bar>:redraw!\<CR>"
  endif
endfunction

function! fn#keymap#n#jump() abort
  if &ft == 'man'
    execute 'Man ' . expand('<cword>')
  else
    call feedkeys("\<C-]>")
  endif
endfunction

" NextDiffOrChunk:
function! fn#keymap#n#next_diff_or_chunk() abort
  let curlnum = line('.')
  if &diff == 1
    normal! ]c
  else
    execute "normal \<Plug>(coc-git-nextchunk)"
  endif
  let s:centered_cursor = v:false
  call timer_start(10, { -> s:put_cursor(curlnum) }, {'repeat': 3})
endfunction

" PrevDiffOrChunk:
function! fn#keymap#n#prev_diff_or_chunk() abort
  let curlnum = line('.')
  if &diff == 1
    normal! [c
  else
    execute "normal \<Plug>(coc-git-prevchunk)"
  endif
  let s:centered_cursor = v:false
  call timer_start(20, { -> s:put_cursor(curlnum) })
endfunction

" put cursor in the vertical center of the window
function! s:put_cursor(saved_lnum) abort
  if s:centered_cursor
    return
  endif
  if line('.') != a:saved_lnum
    normal! zz
    let s:centered_cursor = v:true
  endif
endfunction

" ScrollWindows:
function! fn#keymap#n#scroll_win(direction) abort
  if translator#window#float#has_scroll()
    call translator#window#float#scroll(a:direction)
  elseif skylight#float#has_scroll()
    call skylight#float#scroll(a:direction, 3)
  elseif coc#float#has_scroll()
    call coc#float#scroll(a:direction, 3)
  else
    call fn#window#scroll_prev_win(a:direction, 3)
  endif
endfunction
