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
function! mylightline#Mode()
  if &filetype =~ s:special_filetypes_pattern
    return s:special_filetypes[&filetype]
  endif
  return lightline#mode()
endfunction

" GitBranch:
function! mylightline#GitBranch()
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
function! mylightline#FileFormat()
  if !&buflisted
    return ''
  endif
  return &fileformat == 'unix' ? '' : &fileformat
endfunction

" FileType:
function! mylightline#FileType()
  if !&buflisted
    return ''
  endif
  return strlen(&filetype) ? (WebDevIconsGetFileTypeSymbol() . ' ' . &filetype) : ''
endfunction

" FileEncoding:
function! mylightline#FileEncoding()
  if !&buflisted
    return ''
  endif
  return &fileencoding == 'utf-8' ? '' : &fileencoding
endfunction

" ReadOnly:
function! mylightline#ReadOnly()
  if !&buflisted
    return ''
  endif
  return &readonly ? '' : ''
endfunction

function! mylightline#AsyncRunStatus() abort
  if !&buflisted
    return ''
  endif
  return exists('g:asyncrun_status') ? g:asyncrun_status : ''
endfunction

function! mylightline#FloatermExecStatus() abort
  if !&buflisted
    return ''
  endif
  return exists('g:floaterm_exec_status') ? g:floaterm_exec_status : ''
endfunction

function! mylightline#Translator_Status() abort
  if !&buflisted
    return ''
  endif
  return exists('g:translator_status') ? g:translator_status : ''
endfunction

function! mylightline#Codelf_Status() abort
  if !&buflisted
    return ''
  endif
  return exists('g:codelf_status') ? g:codelf_status : ''
endfunction

" ActiveFileinfo:
function! mylightline#ActiveFileinfo()
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
function! mylightline#InactiveFileinfo()
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
