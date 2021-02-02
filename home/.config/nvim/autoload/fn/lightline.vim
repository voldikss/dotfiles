" ============================================================================
" FileName: lightline.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:special_filetypes = {
      \ 'coc-explorer': 'coc-explorer',
      \ 'floaterm': 'FLOATERM',
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

" ActiveFileinfo:
function! fn#lightline#ActiveFileinfo()
  if &filetype =~ s:special_filetypes_pattern
    return ''
  endif
  if empty(bufname())
    let filepath = getcwd()
  else
    let filepath = substitute(expand('%:p'), $HOME, '~', 'g')
  endif
  let maxwidth = winwidth(0) - 40
  if len(filepath) > maxwidth
    let filepath = pathshorten(filepath)
  endif
  if len(filepath) > maxwidth
    let filepath = expand('%:t')
  endif
  if len(filepath) > maxwidth
    let filepath = ''
  endif
  return filepath
endfunction

" Mode:
function! fn#lightline#Mode()
  if &filetype =~ s:special_filetypes_pattern
    return s:special_filetypes[&filetype]
  endif
  return lightline#mode()
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
  if empty(bufname())
    let filepath = getcwd()
  else
    let filepath = substitute(expand('%:p'), $HOME, '~', 'g')
  endif
  let winwidth = winwidth(0)
  if len(filepath) > winwidth
    let filepath = pathshorten(filepath)
  endif
  if len(filepath) > winwidth
    let filepath = expand('%:t')
  endif
  if len(filepath) > winwidth
    let filepath = ''
  endif
  return filepath
endfunction
