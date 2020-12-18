" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss

" AbsPath:
function! fn#lightline#AbsPath()
  let path = substitute(expand('%:p'), $HOME, '~', 'g')
  if len(path) > winwidth(0)/3
    let path = pathshorten(path)
    if len(path) > winwidth(0)/3
      return ''
    endif
  endif
  return path
endfunction

" Mode:
function! fn#lightline#Mode()
  return &filetype ==# 'coc-explorer' ? 'coc-explorer' :
    \ &filetype ==# 'denite' ? 'Denite' :
    \ &filetype ==# 'gitv' ? 'GitV' :
    \ &filetype ==# 'help' ? 'Help' :
    \ &filetype ==# 'man' ? 'Man' :
    \ &filetype ==# 'qf' && !getwininfo(win_getid(winnr()))[0]['loclist'] ? 'QuickFix' :
    \ &filetype ==# 'qf' && getwininfo(win_getid(winnr()))[0]['loclist'] ? 'Location List' :
    \ &filetype ==# 'startify' ? 'Startify' :
    \ &filetype ==# 'Mundo' ? 'Mundo' :
    \ expand('%:t') =~ '__Tagbar__' ? 'Tagbar' :
    \ expand('%:t') =~ '__vista__' ? 'Vista' :
    \ lightline#mode()
endfunction

" FileName:
function! fn#lightline#FileName()
  let filename = expand('%:t') !=# '' ? expand('%:t') : ''
  let modified = &modified ? ' ✎' : ''
  return filename . modified
endfunction

" GitBranch:
function! fn#lightline#GitBranch()
  if exists('*FugitiveHead') && &filetype !~# '\v(denite|help|man|qf|tagbar|Mundo|vista)'
    let branch = FugitiveHead()
    return branch !=# '' ? ''. branch : ''
  endif
  return ''
endfunction

" FileFormat:
function! fn#lightline#FileFormat()
  return &filetype !=# 'denite' &&
    \ &filetype !=# 'gitv' &&
    \ &filetype !=# 'help' &&
    \ &filetype !=# 'man' &&
    \ &filetype !=# 'qf' &&
    \ &filetype !=# 'startify' &&
    \ &filetype != 'Mundo' &&
    \ expand('%:t') !~ '__vista__' &&
    \ winwidth(0) > 70
    \ ? &fileformat : ''
endfunction

" FileType:
function! fn#lightline#FileType()
  return strlen(&filetype) ? (WebDevIconsGetFileTypeSymbol() . ' ' . &filetype) : ''
endfunction

" FileEncoding:
function! fn#lightline#FileEncoding()
  return &filetype !=# 'denite' &&
    \ &filetype !=# 'gitv' &&
    \ &filetype !=# 'help' &&
    \ &filetype !=# 'man' &&
    \ &filetype !=# 'qf' &&
    \ &filetype !=# 'startify' &&
    \ &filetype !=# 'Mundo' &&
    \ expand('%:t') !~ '__vista__' &&
    \ winwidth(0) > 70
    \ ? &fileencoding : ''
endfunction

" ReadOnly:
function! fn#lightline#ReadOnly()
  return &readonly && &filetype !~# '\v(denite|help|man|qf|startify)' && expand('%:t') !~ ('__vista__') ? '' : ''
endfunction
