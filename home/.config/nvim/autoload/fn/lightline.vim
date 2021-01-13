" ============================================================================
" FileName: lightline.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:special_filetypes = {
  \ 'coc-explorer': 'coc-explorer',
  \ 'floaterm': 'Floaterm',
  \ 'help': 'Help',
  \ 'man': 'Man',
  \ 'Mundo': 'Mundo',
  \ 'MundoDiff': 'MundoDiff',
  \ 'qf': 'QuickFix',
  \ 'startify': 'Startify',
  \ 'vista': 'Vista',
  \ 'vim-plug': 'Plug',
  \ }
let s:special_filetypes_pattern = '\v^(' . join(keys(s:special_filetypes), '|') . ')$'

" AbsPath2:
function! fn#lightline#AbsPath()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif

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
  if &filetype =~ s:special_filetypes_pattern
    return s:special_filetypes[&filetype]
  endif
  return lightline#mode()
endfunction

" FileName:
function! fn#lightline#FileName()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  let filename = expand('%:t') !=# '' ? expand('%:t') : ''
  let modified = &modified ? ' ✎' : ''
  return filename . modified
endfunction

" GitBranch:
function! fn#lightline#GitBranch()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  if exists('*FugitiveHead')
    let branch = FugitiveHead()
    return branch !=# '' ? ''. branch : ''
  endif
  return ''
endfunction

" FileFormat:
function! fn#lightline#FileFormat()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return &fileformat == 'unix' ? '' : &fileformat
endfunction

" FileType:
function! fn#lightline#FileType()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return strlen(&filetype) ? (WebDevIconsGetFileTypeSymbol() . ' ' . &filetype) : ''
endfunction

" FileEncoding:
function! fn#lightline#FileEncoding()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

" ReadOnly:
function! fn#lightline#ReadOnly()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return &readonly ? '' : ''
endfunction

function! fn#lightline#AsyncRunStatus() abort
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return exists('g:asyncrun_status') ? g:asyncrun_status : ''
endfunction

function! fn#lightline#Translator_Status() abort
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return exists('g:translator_status') ? g:translator_status : ''
endfunction

function! fn#lightline#Codelf_Status() abort
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  return exists('g:codelf_status') ? g:codelf_status : ''
endfunction

" InactiveFileinfo: no pathshorten
function! fn#lightline#InactiveFileinfo()
  if &filetype =~ s:special_filetypes_pattern
    return s:special_filetypes[&filetype]
  endif
  return substitute(expand('%:p'), $HOME, '~', 'g')
endfunction
