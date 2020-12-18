" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss

let g:winmgr_only_one_win = get(g:, 'winmgr_only_one_win', 1)
let s:winmgr_windows = {
  \ 'coc-explorer': {
    \ 'open': 'CocCommand explorer',
    \ 'close': 'CocCommand explorer'
  \ },
  \ 'vista': {
    \ 'open':'Vista',
    \ 'close': 'Vista!'
  \ },
  \ 'qf': {
    \ 'open': 'copen 9',
    \ 'close': 'cclose'
  \ },
  \ 'mundo': {
    \ 'open': 'MundoToggle',
    \ 'close': 'MundoToggle'
  \ },
  \ 'floaterm': {
    \ 'open': 'FloatermToggle',
    \ 'close': 'FloatermToggle'
  \ }
\ }

function! fn#window#switch_window(winname) abort
  let found_winnr = 0
  let other_winids = []
  for winnr in range(1, winnr('$'))
    let filetype = getbufvar(winbufnr(winnr), '&filetype')
    if filetype == a:winname
      let found_winnr = winnr
    elseif has_key(s:winmgr_windows, filetype)
      call add(other_winids, win_getid(winnr))
    endif
  endfor

  if found_winnr > 0
    execute s:winmgr_windows[a:winname]['close']
  else
    if g:winmgr_only_one_win
      for winid in other_winids
        call nvim_win_close(winid, v:true)
      endfor
    endif
    execute s:winmgr_windows[a:winname]['open']
  endif
endfunction

function! fn#window#Complete(arg_lead,cmd_line,cursor_pos) abort
  let lst = keys(s:winmgr_windows)
  let cmd_line_before_cursor = a:cmd_line[:a:cursor_pos - 1]
  let args = split(cmd_line_before_cursor, '\v\\@<!(\\\\)*\zs\s+', 1)
  call remove(args, 0)

  if len(args) ==# 1
    if args[0] ==# ''
      return sort(lst)
    else
      let prefix = args[-1]
      let candidates = filter(lst, 'v:val[:len(prefix) - 1] ==# prefix')
      return sort(candidates)
    endif
  endif
endfunction
