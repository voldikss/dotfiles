" ============================================================================
" FileName: textobj.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! textobj#(pattern) abort
  let pos = getpos('.')
  let lnum = pos[1]
  let cnum = pos[2]
  let line = getline(lnum)

  let [str, start, end] = s:matchstrposlast(line[:cnum-1], a:pattern)
  if !empty(str)
    let p1 = start + 1
    let p2 = end
    " match from prematch's start, to see if current cursor was included in the match
    let [str, start, end] = matchstrpos(line, a:pattern, start)
    if end >= cnum
      let p1 = start + 1
      let p2 = end
    else
      let [str, start, end] = matchstrpos(line, a:pattern, end)
      if !empty(str)
        let p1 = start + 1
        let p2 = end
      endif
    endif
  else
    " match from begin to the end of the line, get the first match
    let [str, start, end] = matchstrpos(line, a:pattern)
    if !empty(str)
      let p1 = start + 1
      let p2 = end
    endif
  endif

  " visual select match part
  if exists('p1')
    call cursor(lnum, p1)
    normal v
    call cursor(lnum, p2)
  endif
endfunction

function! s:matchstrposlast(str, pat)
  let p1 = -1
  let p2 = -1
  let s = ''
  let end = 0
  while 1
    let [str, start, end] = matchstrpos(a:str, a:pat, end)
    if end != -1
      let s = str
      let p1 = start
      let p2 = end
    else
      break
    endif
  endwhile
  return [s, p1, p2]
endfunction
