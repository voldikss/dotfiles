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
function! keymap#n#left_square_brackets() abort
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
function! keymap#n#right_square_brackets() abort
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
function! keymap#n#CR() abort
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
" NOTE: do not use `bwipeout` to replace `bdelete`!
function! keymap#n#safe_bdelete() abort
  " is the last buffer
  if len(getbufinfo({'buflisted':1})) == 1
    if bufname() == ''
      q!
    else
      bdelete!
    endif
  else
    let bufnr = bufnr()
    let jumplist = split(execute('jumps'), '\n')
    if len(jumplist) > 2
      let cur_idx = 0
      for item in jumplist
        if item[0] == '>'
          break
        else
          let cur_idx += 1
        endif
      endfor
      let previtem = jumplist[cur_idx - 1]
      " let prevfilename = matchstr(prevlocation, '\d\s\+\d\s\+\d\s\zs.*\ze$')
      let prevfile = previtem[16:]
      if filereadable(prevfile) && bufloaded(prevfile)
        " jump to the previous location
        execute "normal! \<C-o>"
      endif
    endif

    if winnr('$') == 1
      execute 'bdelete!' bufnr
    else
      " NOTE: I have to set `equalalways` to true, otherwise CocList would throw
      " `No enough rooms` error. But I like `noequalalways` much more.
      "Also note that setting winfixheight/winfixwidth can block `equalalways`
      let width = winwidth(0)
      let height = winheight(0)
      if bufnr == bufnr()
        bn | vs | bp
      else
        vs | execute 'b' bufnr
      endif
      execute 'bdelete!' bufnr
      execute 'resize ' height
      execute 'vertical resize ' width
      redraw!
    endif
  endif
endfunction

function! keymap#n#jump() abort
  if &ft == 'man'
    execute 'Man ' . expand('<cword>')
  else
    call feedkeys("\<C-]>")
  endif
endfunction

" NextDiffOrChunk:
function! keymap#n#next_diff_or_chunk() abort
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
function! keymap#n#prev_diff_or_chunk() abort
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
function! keymap#n#scroll_win(direction) abort
  if translator#window#float#has_scroll()
    call translator#window#float#scroll(a:direction)
  elseif skylight#float#has_scroll()
    call skylight#float#scroll(a:direction, 3)
  elseif coc#float#has_scroll()
    call coc#float#scroll(a:direction, 3)
  else
    call window#scroll_prev_win(a:direction, 3)
  endif
endfunction

" EmptyExRepeatPreviousCommand:
" NOTE: 
" - feedkeys() {mode} argument must be `nt` to prevent remapping for `:`
" - this will cause problems for those no-nore mappings which have `:` 
function! keymap#n#ex_repeat_previous_command() abort
  let history = split(execute('history cmd -2,-1'), "\n")
  let prevcmd = matchstr(history[2], '^>\=\s\+\d\+\s\+\zs.*\ze$')
  let prevprevcmd = matchstr(history[1], '^>\=\s\+\d\+\s\+\zs.*\ze$')
  echohl Comment
  echo ':'.prevcmd
  echohl None
  let ch = nr2char(getchar())
  if ch == "\<CR>"
    call feedkeys(":".prevcmd."\<CR>", 'nt')
  elseif ch == "\<Esc>"
    call feedkeys("\<Esc>")
  elseif ch == "\<Space>"
    call feedkeys(":".prevcmd."\<Space>", 'nt')
  elseif ch == "" " Backspace
    call feedkeys(":".prevcmd."\<BS>", 'nt')
  elseif ch == "\<Tab>"
    call feedkeys(":".prevcmd."\<Tab>", 'nt')
  elseif ch == "\<C-w>"
    call feedkeys(":".prevcmd."\<C-w>", 'n')
  elseif ch == "\<Left>" || ch == "\<C-h>"
    call feedkeys(":".prevcmd."\<Left>", 'nt')
  elseif ch == "\<Home>" || ch == "\<C-a>"
    call feedkeys(":".prevcmd."\<Home>", 'nt')
  elseif ch == "\<S-Left>" || ch == "\<C-b>"
    call feedkeys(":".prevcmd."\<S-Left>", 'nt')
  elseif ch == "\<Up>" || ch == "\<C-p>"
    call feedkeys(":\<Up>\<Up>", 'nt')
  elseif ch == "\<C-u>"
    call feedkeys(":", 'nt')
  else
    call feedkeys(":".ch, 'nt')
  endif
endfunction
