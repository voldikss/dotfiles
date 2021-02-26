" ============================================================================
" FileName: mark.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:colors = ['#aeee00', '#ff0000', '#0000ff', '#b88823', '#ffa724', '#ff2c4b']
let s:has_builtin_colors = 0
let s:words = []
let s:modes = []
let s:mids = {}
let s:cache = []

function! s:color_word(word, mode)
  if !(s:has_builtin_colors)
    call s:build_colors()
  endif

  " gets the lowest unused index
  let n = index(s:words, 0)
  if (n == -1)
    let n = s:cache[0]
    call s:uncolor_word(s:words[n])
  endif

  let mid = 595129 + n
  let s:words[n] = a:word
  let s:modes[n] = a:mode
  let s:mids[a:word] = mid

  call s:apply_color_to_word(n, a:word, a:mode, mid)
  call s:mark_cache(n)
endfunction

function! s:apply_color_to_word(n, word, mode, mid)
  let case = s:check_ignore_case(a:word) ? '\c' : '\C'
  if a:mode == 'v'
    let pat = case . '\V\zs' . escape(a:word, '\') . '\ze'
  else
    let pat = case . '\V\<' . escape(a:word, '\') . '\>'
  endif

  try
    call matchadd("MarkWord" . (a:n + 1), pat, 1, a:mid)
  catch /E801/      " match id already taken.
  endtry
endfunction

function! s:nearest_group_at_cursor() abort
  let l:matches = {}
  for l:match_item in getmatches()
    let l:mids = filter(items(s:mids), 'v:val[1] == l:match_item.id')
    if len(l:mids) == 0
      continue
    endif
    let l:word = l:mids[0][0]
    let l:position = match(getline('.'), l:match_item.pattern)
    if l:position > -1
      if col('.') > l:position && col('.') <= l:position + len(l:word)
        return l:word
      endif
    endif
  endfor
  return ''
endfunction

function! s:uncolor_word(word)
  let index = index(s:words, a:word)

  if (index > -1)
    let mid = s:mids[a:word]

    silent! call matchdelete(mid)
    let s:words[index] = 0
    unlet s:mids[a:word]
  endif
endfunction

function! s:getmatch(mid) abort
  return filter(getmatches(), 'v:val.id==a:mid')[0]
endfunction

function! mark#jump(direction)
  let curword = s:nearest_group_at_cursor()

  if (s:check_ignore_case(curword))
    let curword = tolower(curword)
  endif

  if (index(s:words, curword) > -1)
    let l:index = index(s:words, curword)
    let l:mode = s:modes[index]
    let case = s:check_ignore_case(curword) ? '\c' : '\C'
    if l:mode == 'v'
      let pat = case . '\V\zs' . escape(curword, '\') . '\ze'
    else
      let pat = case . '\V\<' . escape(curword, '\') . '\>'
    endif
    let flag = ''
    if !(a:direction)
      let flag = 'b'
    endif
    call search(pat, flag)
    normal! zz
  else
    try
      if (a:direction)
        normal! nzz
      else
        normal! Nzz
      endif
    catch /E486/
      call util#show_msg('Pattern not found', 'warning')
    endtry
  endif
endfunction

function! mark#do(mode) range
  if a:mode == 'v'
    let curword = util#get_selected_text('v', 2, -1, -1)[0]
  else
    let curword = expand('<cword>') . ''
  endif
  if !(len(curword))
    return
  endif
  if (s:check_ignore_case(curword))
    let curword = tolower(curword)
  endif
  if (index(s:words, curword) == -1)
    call s:color_word(curword, a:mode)
  else
    call s:uncolor_word(curword)
  endif
endfunction

function! mark#uncolor_all()
  for word in s:words
    " check that word is actually a String since '0' is falsy
    if (type(word) == 1)
      call s:uncolor_word(word)
    endif
  endfor
endfunction

function! s:recolor_all()
  let i = 0
  for word in s:words
    if (type(word) == 1)
      let mode = s:modes[i]
      let mid = s:mids[word]
      call s:apply_color_to_word(i, word, mode, mid)
    endif
    let i += 1
  endfor
endfunction

" returns true if the ignorecase flag needs to be used
function! s:check_ignore_case(word)
  " return false if case sensitive is used
  if (exists('g:mark_case_sensitive'))
    return !g:mark_case_sensitive
  endif
  " checks ignorecase
  " and then if smartcase is on, check if the word contains an uppercase char
  return &ignorecase && (!&smartcase || (match(a:word, '\u') == -1))
endfunction

" moves the index to the back of the s:recentlyUsed list
function! s:mark_cache(n)
  let index = index(s:cache, a:n)
  call remove(s:cache, index)
  call add(s:cache, a:n)
endfunction

" initialise highlight colors from list of GUIColors
" initialise length of s:interestingWord list
" initialise s:recentlyUsed list
function! s:build_colors()
  if (s:has_builtin_colors)
    return
  endif
  let word_colors = s:colors

  " fisher-yates shuffle
  let i = len(word_colors)-1
  while i > 0
    let j = s:random(i)
    let temp = word_colors[i]
    let word_colors[i] = word_colors[j]
    let word_colors[j] = temp
    let i -= 1
  endwhile
  " select ui type
  " highlight group indexed from 1
  let idx = 1
  for c in word_colors
    execute 'hi! def MarkWord' . idx . ' guibg=' . c . ' guifg=Black'
    call add(s:words, 0)
    call add(s:modes, 'n')
    call add(s:cache, idx-1)
    let idx += 1
  endfor
  let s:has_builtin_colors = 1
endfunc

" helper function to get random number between 0 and n-1 inclusive
function! s:random(n)
  let timestamp = reltimestr(reltime())[-2:]
  return float2nr(floor(a:n * timestamp/100))
endfunction
