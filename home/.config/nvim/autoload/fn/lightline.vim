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

" Mode:
function! fn#lightline#Mode()
  if &filetype =~ s:special_filetypes_pattern
    return s:special_filetypes[&filetype]
  endif
  return lightline#mode()
endfunction

" GitBranch:
function! fn#lightline#GitBranch()
  if !&buflisted
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
  if !&buflisted
    return ''
  endif
  return &fileformat == 'unix' ? '' : &fileformat
endfunction

" FileType:
function! fn#lightline#FileType()
  if !&buflisted
    return ''
  endif
  return strlen(&filetype) ? (WebDevIconsGetFileTypeSymbol() . ' ' . &filetype) : ''
endfunction

" FileEncoding:
function! fn#lightline#FileEncoding()
  if !&buflisted
    return ''
  endif
  return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

" ReadOnly:
function! fn#lightline#ReadOnly()
  if !&buflisted
    return ''
  endif
  return &readonly ? '' : ''
endfunction

function! fn#lightline#AsyncRunStatus() abort
  if !&buflisted
    return ''
  endif
  return exists('g:asyncrun_status') ? g:asyncrun_status : ''
endfunction

function! fn#lightline#FloatermExecStatus() abort
  if !&buflisted
    return ''
  endif
  return exists('g:floaterm_exec_status') ? g:floaterm_exec_status : ''
endfunction

function! fn#lightline#Translator_Status() abort
  if !&buflisted
    return ''
  endif
  return exists('g:translator_status') ? g:translator_status : ''
endfunction

function! fn#lightline#Codelf_Status() abort
  if !&buflisted
    return ''
  endif
  return exists('g:codelf_status') ? g:codelf_status : ''
endfunction

" ActiveFileinfo:
function! fn#lightline#ActiveFileinfo()
  if !&buflisted
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
