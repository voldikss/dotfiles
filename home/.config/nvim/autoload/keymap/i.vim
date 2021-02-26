" ============================================================================
" FileName: i.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Insert: <BS>
function! keymap#i#BS() abort
  " vim has charcol() but it has not patched to neovim yet.
  " virtcol() seems enough?
  let colnr = virtcol('.')
  if colnr == 1
    if line('.')  != 1
      return  "\<ESC>kA\<Del>"
    else
      return ""
    endif
  endif

  let line = getline('.')       " don't use trim() here
  let paren = strcharpart(line, colnr-2, 2)
  let pairs = ['()', '[]', '{}', '<>', '%%', '$$', '**', '""', "''", '~~', '``', '“”', '‘’', '【】]', '《》']
  if index(pairs, paren) >=0
    return "\<Left>\<Del>\<Del>"
  else
    let prefix = line[:colnr-2]
    if prefix =~ '^\s\+$' && len(prefix) % &shiftwidth == 0
      return "\<BS>"
    else
      return "\<Left>\<Del>"
    endif
  endif
endfunction

" Insert: <CR>
function! keymap#i#CR() abort
  let line = getline('.') " can not use trim
  if pumvisible()
    return "\<C-y>"
  elseif '}' == strcharpart(line, getpos('.')[2]-1, 1)
  " elseif index([')', ']', '}', '`'], strcharpart(line, getpos('.')[2]-1, 1)) >= 0
    return "\<CR>\<Esc>O"
  elseif strcharpart(line, getpos('.')[2]-1,2) == '</'
    return "\<CR>\<Esc>O"
  else
    return "\<CR>"
  endif
endfunction

" Insert: <Esc>
function! keymap#i#Esc()
  let colnr = getpos('.')[2]
  let linelen = len(getline('.'))
  if colnr == (linelen + 1)
    return "\<Esc>"
  else
    return "\<Esc>\<Right>"
  endif
endfunction

" Insert: FlyOutPairs
function! keymap#i#flyoutpairs(key)
  return "\<ESC>:call search("."'".a:key."'".")\<CR>a"
endfunction
