" ============================================================================
" FileName: argument.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" https://github.com/gaving/vim-textobj-argument/blob/master/plugin/argtextobj.vim
function! fn#textobj#argument#(inner, visual)
  let cnt = v:count1
  let current_c = getline('.')[getpos('.')[2]-1]
  if current_c==',' || current_c=='('
    normal! l
  endif

  " get out of "double quoted string" because [( does not take effect in it
  call <SID>GetOutOfDoubleQuote()

  let rightup      = <SID>GetOuterFunctionParenthesis()       " on (
  if empty(rightup)
    " no left parenthesis found, not inside function arguments
    execute "normal! \<C-\>\<C-n>\<Esc>" | " Beep.
    return
  endif
  let rightup_pair = <SID>GetPair(rightup)                    " before )
  if rightup_pair == rightup
    " no matching right parenthesis found, search for incomplete function
    " definition until end of current line.
    let rightup_pair = [0, line('.'), col('$'), 0]
  endif
  let arglist_str  = <SID>GetInnerText(rightup, rightup_pair) " inside ()
  if getline('.')[rightup[2]-1]=='('
    " left parenthesis in the current line
    " cursor offset from rightup
    let offset  = getpos('.')[2] - rightup[2] - 1 " -1 for the removed parenthesis
  else
    " left parenthesis in a previous line; retrieve the (partial when there's a
    " matching right parenthesis) current line from the arglist_str.
    for line in split(arglist_str, "\n")
      if stridx(getline('.'), line) == 0
        let arglist_str = line
        break
      endif
    endfor
    let offset  = getpos('.')[2] - 1
  endif
  " replace all parentheses and commas inside them to '_'
  let arglist_sub  = arglist_str
  let arglist_sub = substitute(arglist_sub, "'".'\([^'."'".']\{-}\)'."'", '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g') " replace '..' => (__)
  let arglist_sub = substitute(arglist_sub, '\[\([^'."'".']\{-}\)\]', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')     " replace [..] => (__)
  let arglist_sub = substitute(arglist_sub, '<\([^'."'".']\{-}\)>', '\="(".substitute(submatch(1), ".", "_", "g").")"', 'g')       " replace <..> => (__)
  let arglist_sub = substitute(arglist_sub, '"\([^'."'".']\{-}\)"', '(\1)', 'g') " replace ''..'' => (..)
  """echo 'transl quotes: ' . arglist_sub
  while stridx(arglist_sub, '(')>=0 && stridx(arglist_sub, ')')>=0
    let arglist_sub = substitute(arglist_sub , '(\([^()]\{-}\))', '\="<".substitute(submatch(1), ",", "_", "g").">"', 'g')
    """echo 'sub single quot: ' . arglist_sub
  endwhile

  " the beginning/end of this argument
  let thisargbegin = <SID>GetPrevCommaOrBeginArgs(arglist_sub, offset)
  let thisargend   = <SID>GetNextCommaOrEndArgs(arglist_sub, offset, cnt)

  " function(..., the_nth_arg, ...)
  "             [^left]    [^right]
  let left  = offset - thisargbegin
  let right = thisargend - thisargbegin

  """echo 'on(='. rightup[2] . ' before)=' . rightup_pair[2]
  """echo arglist_str
  """echo arglist_sub strlen(arglist_sub)
  """echo offset
  """echo 'argbegin='. thisargbegin . '  argend='. thisargend
  """echo 'left=' . left . '  right='. right

  let delete_trailing_space = 0
  if a:inner
    " ia
    call <SID>MoveLeft(left)
    let right -= <SID>MoveToNextNonSpace()
  else
    " aa
    if thisargbegin==0 && thisargend==strlen(arglist_sub)-1
      " only single argument
      call <SID>MoveLeft(left)
    elseif thisargbegin==0
      " head of the list (do not delete '(')
      call <SID>MoveLeft(left)
      let right += 1
      let delete_trailing_space = 1
    else
      " normal or tail of the list
      call <SID>MoveLeft(left+1)
      let right += 1
    endif
  endif

  exe 'normal! v'

  call <SID>MoveRight(right)
  if delete_trailing_space
    exe 'normal! l'
    call <SID>MoveToNextNonSpace()
    exe 'normal! h'
  endif

  if &selection ==# 'exclusive'
    normal! l
  endif
endfunction

let g:argumentobject_force_toplevel = 0
function! s:GetOutOfDoubleQuote()
  " get out of double quoteed string (one letter before the beginning)
  let line = getline('.')
  let pos_save = getpos('.')
  let mark_b = getpos("'<")
  let mark_e = getpos("'>")
  let repl='_'
  let did_modify = 0
  if getline('.')[getpos('.')[2]-1]=='_'
    let repl='?'
  endif

  while 1
    exe 'silent! normal! ^va"'
    normal! :\<ESC>\<CR>
    if getpos("'<")==getpos("'>")
      break
    endif
    exe 'normal! gvr' . repl
    let did_modify = 1
  endwhile

  call setpos('.', pos_save)
  if getline('.')[getpos('.')[2]-1]==repl
    " in double quote
    if did_modify
      silent undo
      call setpos('.', pos_save)
    endif
    if getpos('.')==getpos("'<")
      normal! h
    else
      normal! F"
    endif
  elseif did_modify
    silent undo
    call setpos('.', pos_save)
  endif
endfunction

function! s:GetOuterFunctionParenthesis()
  let pos_save = getpos('.')
  let rightup_before = pos_save
  silent! normal! [(
  let rightup_p = getpos('.')
  if rightup_p == rightup_before
    return []
  endif
  while rightup_p != rightup_before
    if ! g:argumentobject_force_toplevel && getline('.')[getpos('.')[2]-1-1] =~ '[a-zA-Z0-9_]'
      " found a function
      break
    endif
    let rightup_before = rightup_p
    silent! normal! [(
    let rightup_p = getpos('.')
  endwhile
  call setpos('.', pos_save)
  return rightup_p
endfunction

function! s:GetPair(pos)
  let pos_save = getpos('.')
  call setpos('.', a:pos)
  normal! %h
  let pair_pos = getpos('.')
  call setpos('.', pos_save)
  return pair_pos
endfunction

function! s:GetInnerText(r1, r2)
  let pos_save = getpos('.')
  let cb_save = &clipboard
  set clipboard= " Avoid clobbering the selection and clipboard registers.
  let reg_save = @@
  let regtype_save = getregtype('"')
  call setpos('.', a:r1)
  normal! lv
  call setpos('.', a:r2)
  if &selection ==# 'exclusive'
    normal! l
  endif
  silent normal! y
  let val = @@
  call setpos('.', pos_save)
  call setreg('"', reg_save, regtype_save)
  let &clipboard = cb_save
  return val
endfunction

function! s:GetPrevCommaOrBeginArgs(arglist, offset)
  let commapos = strridx(a:arglist, ',', a:offset)
  return max([commapos+1, 0])
endfunction

function! s:GetNextCommaOrEndArgs(arglist, offset, count)
  let commapos = a:offset - 1
  let c = a:count
  while c > 0
    let commapos = stridx(a:arglist, ',', commapos + 1)
    if commapos == -1
      if c > 1
        execute "normal! \<C-\>\<C-n>\<Esc>" | " Beep.
      endif
      return strlen(a:arglist)-1
    endif
    let c -= 1
  endwhile
  return commapos-1
endfunction

function! s:MoveToNextNonSpace()
  let oldp = getpos('.')
  let moved = 0
  """echo 'move:' . getline('.')[getpos('.')[2]-1]
  while getline('.')[getpos('.')[2]-1]=~'\s'
    normal! l
    if oldp == getpos('.')
      break
    endif
    let oldp = getpos('.')
    let moved += 1
  endwhile
  return moved
endfunction

function! s:MoveLeft(num)
  if a:num>0
    exe 'normal! ' . a:num . 'h'
  endif
endfunction

function! s:MoveRight(num)
  if a:num>0
    exe 'normal! ' . a:num . 'l'
  endif
endfunction
