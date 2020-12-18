" Indent of `public/private/protected signals/slots` is &shiftwidth - 2
" Indent of `Q_OBJECT` is &shiftwidth
" See L12-18 and L44-49

function! QtCppIndent(lnum)
  let line = getline(a:lnum)
  " Patterns used to recognise labels and search for the start
  " of declarations
  let qt_label_pat1='signals:\|slots:\|public:\|protected:\|private:'
  let qt_label_pat2 = 'Q_OBJECT'
  let other_label_pat = 'break;'
  let declpat = '\(;\|{\|}\)\s*\(//.*\)\s*$'
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
    return cindent(a:lnum)
  endif
  " Save cursor position and move to the line we're indenting
  let pos=getpos('.')
  call setpos('.', [0, a:lnum, 1, 0])
  " Find the beginning of the previous declaration (this is what
  " cindent will mimic)
  call search(declpat, 'beW', a:lnum>10 ? a:lnum-10 : 0)
  let prevlnum = line('.')
  let prevline = getline(prevlnum)
  " Find the beginning of the next declaration after that (this may
  " just get us back where we started)
  call search(declpat, 'eW', a:lnum<=line('$')-10 ? a:lnum+10 : 0)
  let nextlnum = line('.')
  " Restore the cursor position
  call setpos('.', pos)
  " If the prevline contains qt_label_pat1, use `&shiftwidth + 2`
  " If contains `Q_OBJECT`, use the same indent as `Q_OBJECT`
  if prevline =~ qt_label_pat1
    return indent(prevlnum) + 2
  elseif prevline =~ qt_label_pat2
    return indent(prevlnum)
  elseif prevline =~ other_label_pat
    return indent(prevlnum) - &shiftwidth
  else
    return cindent(a:lnum)
  endif
  " Otherwise we adjust so the beginning of the declaration is one
  " shiftwidth in
  return &shiftwidth
endfunction
setlocal indentexpr=QtCppIndent(v:lnum)
