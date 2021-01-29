" ============================================================================
" FileName: n.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" NOTE: 一般分两种情况
"   - 按键命令 
"     - without "<xxx>"(e.g. "<C-o>", "<Plug>(xxx)") => normal! xxxx
"     - with "<xxx>" => execute "normal! \<xxx>"
"   - 普通命令，即 viml 语句 => 直接写
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

" Normal: delete buffer without closing window
function! fn#keymap#n#safe_bdelete() abort
  " is the last buffer
  if len(getbufinfo({'buflisted':1})) == 1 && winnr('$') == 1
    if bufname() == ''
      q!
    else
      bwipeout
    endif
  else
    let bufnr = bufnr()
    " jump to the previous location
    execute "normal! \<C-o>"

    " NOTE: I have to set `equalalways` to true, otherwise CocList would throw
    " `No enough rooms` error. But I like `noequalalways` much more. 
    "Also note that setting winfixheight/winfixwidth can block `equalalways`
    let width = winwidth(0)
    let height = winheight(0)
    bp|vsp|bn|execute 'bwipeout' bufnr
    execute 'resize ' . height
    execute 'vertical resize ' . width
    redraw!
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
