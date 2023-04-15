" Indent of `public/private/protected signals/slots` is &shiftwidth - 2
" Indent of `Q_OBJECT` is &shiftwidth
" See L12-18 and L44-49

function! QtCppIndent()
  let line = getline(v:lnum)
  let prevlnum = prevnonblank(v:lnum - 1)
  let prevline = getline(prevlnum)

  " Patterns used to recognise labels and search for the start
  " of declarations
  let qt_label_pat1 ='signals:\|slots:\|public:\|protected:\|private:'
  let qt_label_pat2 = 'Q_OBJECT'
  let declpat = '\(;\|{\|}\|:\)\s*\(//.*\)*$'

  " If the line is a label, it's a no brainer
  if line =~ qt_label_pat1
    return &shiftwidth - 2
  endif
  " Use &shiftwidth for Q_OBJECT macro
  if line =~ qt_label_pat2
    return &shiftwidth
  endif
  " If the line starts with a closing brace, it's also easy: use cindent
  if line =~ '^\s*}'
    return indent(prevlnum)
  endif
  " `case` should have the identical indent value with `switch`
  if line =~ 'case:|default:'
    let pos = getpos('.')
    call search('switch', 'beW')
    let switch_lnum = line('.')
    call setpos('.', pos)
    return indent(prevlnum)
  endif

  " `case` should have the identical indent value with `switch`
  if prevline =~ 'switch\s('
    return indent(prevlnum)
  endif
  if prevline =~ '^\s*case\s.*$'
    return indent(prevlnum) + &shiftwidth
  endif
  " Fix after `break;` indentation
  if prevline =~ '^\s\+break;'
    return indent(prevlnum) - &shiftwidth
  endif
  if prevline =~ '^\s*template.*>$'
    return indent(prevlnum)
  endif
  if prevline =~ '^\s*}\s*\(//.*\)*$'
    return indent(prevlnum)
  endif
  if prevline =~ 'default:'
    return indent(prevlnum) + &shiftwidth
  endif

  " Save cursor position and move to the line we're indenting
  let pos = getpos('.')
  call setpos('.', [0, v:lnum, 1, 0])
  " Find the beginning of the previous declaration (this is what
  " cindent will mimic)
  call search(declpat, 'beW', v:lnum>10 ? v:lnum-10 : 0)
  let prevlnum = line('.')
  let prevline = getline(prevlnum)
  " Find the beginning of the next declaration after that (this may
  " just get us back where we started)
  call search(declpat, 'eW', v:lnum<=line('$')-10 ? v:lnum+10 : 0)
  let nextlnum = line('.')
  " Restore the cursor position
  call setpos('.', pos)
  " If the prevline contains qt_label_pat1, use `&shiftwidth + 2`
  " If contains `Q_OBJECT`, use the same indent as `Q_OBJECT`
  if prevline =~ qt_label_pat1
    return indent(prevlnum) + 2
  elseif prevline =~ qt_label_pat2
    return indent(prevlnum)
  else
    return cindent(v:lnum)
  endif
  " Otherwise we adjust so the beginning of the declaration is one
  " shiftwidth in
  return &shiftwidth
endfunction
setlocal indentexpr=QtCppIndent()
