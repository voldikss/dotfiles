" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description:
"   Redefine man#complete function in /usr/local/share/nvim/runtime/autoload/man.vim
"   Thanks https://github.com/vim-utils/vim-man
" ============================================================================

" load guard {{{1

if exists('g:autoloaded_man_completion')
  finish
endif
let g:autoloaded_man_completion = 1

" }}}
" man#completion#run {{{1

function! man#complete(A, L, P)
  let manpath = s:man_helpers_manpath()
  if manpath =~# '^\s*$'
    return []
  endif
  let section = s:get_manpage_section(a:L, a:P)
  let path_glob = s:man_helpers_get_path_glob(manpath, section, '', ',')
  let matching_files = s:man_helpers_expand_path_glob(path_glob, a:A)
  return s:strip_file_names(matching_files)
endfunction

" extracts the manpage section number (if there is one) from the command
function! s:get_manpage_section(line, cursor_position)
  " extracting section argument from the line
  let leading_line = strpart(a:line, 0, a:cursor_position)
  let section_arg = matchstr(leading_line, '^\s*\S\+\s\+\zs\S\+\ze\s\+')
  if !empty(section_arg)
    return s:man_helpers_extract_permitted_section_value(section_arg)
  endif
  " no section arg or extracted section cannot be used for man dir name globbing
  return ''
endfunction

" strips file names so they correspond manpage names
function! s:strip_file_names(matching_files)
  if empty(a:matching_files)
    return []
  else
    let matches = []
    let len = 0
    for manpage_path in a:matching_files
      " since already looping also count list length
      let len += 1
      call add(matches, s:man_helpers_strip_dirname_and_extension(manpage_path))
    endfor
    " remove duplicates from small lists (it takes noticeably longer
    " and is less relevant for large lists)
    return len > 500 ? matches : filter(matches, 'index(matches, v:val, v:key+1)==-1')
  endif
endfunction

" }}}

" load guard {{{1

if exists('g:autoloaded_man_helpers')
  finish
endif
let g:autoloaded_man_helpers = 1

" }}}
" s:man_helpers_section_arg and man#helpers#find_arg {{{1

let s:section_arg = ''
let s:find_arg = '-w'
try
  if !has('win32') && $OSTYPE !~ 'cygwin\|linux' && system('uname -s') =~ 'SunOS' && system('uname -r') =~ '^5'
    let s:section_arg = '-s'
    let s:find_arg = '-l'
  endif
catch /E145:/
  " Ignore the error in restricted mode
endtry

function! s:man_helpers_section_arg()
  return s:section_arg
endfunction

function! s:man_helpers_find_arg()
  return s:find_arg
endfunction

" }}}
" s:man_helpers_error {{{1

function! s:man_helpers_error(str)
  echohl ErrorMsg
  echomsg a:str
  echohl None
endfunction

" }}}
" s:man_helpers_get_cmd_arg {{{1

function! s:man_helpers_get_cmd_arg(sect, page)
  if a:sect == ''
    return a:page
  else
    return s:man_helpers_section_arg().' '.a:sect.' '.a:page
  endif
endfunction

" }}}
" s:man_helpers_set_manpage_buffer_name {{{1

function! s:man_helpers_set_manpage_buffer_name(page, section)
  silent exec 'edit '.s:manpage_buffer_name(a:page, a:section)
endfunction

function! s:manpage_buffer_name(page, section)
  if !empty(a:section)
    return a:page.'('.a:section.')\ manpage'
  else
    return a:page.'\ manpage'
  endif
endfunction

" }}}
" s:man_helpers_load_manpage_text {{{1

function! s:man_helpers_load_manpage_text(page, section)
  setlocal modifiable
  silent keepj norm! 1GdG
  let $MANWIDTH = s:man_helpers_manwidth()
  silent exec 'r!'.g:vim_man_cmd.' '.s:man_helpers_get_cmd_arg(a:section, a:page). ' 2>/dev/null | col -b'
  call s:remove_blank_lines_from_top_and_bottom()
  setlocal filetype=man
  setlocal nomodifiable
endfunction

function! s:remove_blank_lines_from_top_and_bottom()
  while line('$') > 1 && getline(1) =~ '^\s*$'
    silent keepj norm! ggdd
  endwhile
  while line('$') > 1 && getline('$') =~ '^\s*$'
    silent keepj norm! Gdd
  endwhile
  silent keepj norm! gg
endfunction

" }}}
" s:man_helpers_manwidth {{{1

" Default manpage width is the width of the screen. Change this with
" 'g:man_width'. Example: 'let g:man_width = 120'.
function! s:man_helpers_manwidth()
  if exists('g:man_width')
    return g:man_width
  else
    return winwidth(0)
  end
endfunction

" }}}
" s:man_helpers_extract_permitted_section_value {{{1

function! s:man_helpers_extract_permitted_section_value(section_arg)
  if a:section_arg =~# '^*$'
    " matches all dirs with a glob 'man*'
    return a:section_arg
  elseif a:section_arg =~# '^\d[xp]\?$'
    " matches dirs: man1, man1x, man1p
    return a:section_arg
  elseif a:section_arg =~# '^[nlpo]$'
    " matches dirs: mann, manl, manp, mano
    return a:section_arg
  elseif a:section_arg =~# '^\d\a\+$'
    " take only first digit, sections 3pm, 3ssl, 3tiff, 3tcl are searched in man3
    return matchstr(a:section_arg, '^\d')
  else
    return ''
  endif
endfunction

" }}}
" s:man_helpers_get_path_glob {{{1

" creates a string containing shell globs suitable to finding matching manpages
function! s:man_helpers_get_path_glob(manpath, section, file, separator)
  let section_part = empty(a:section) ? '*' : a:section
  let file_part = empty(a:file) ? '' : a:file
  let man_globs = substitute(a:manpath.':', ':', '/*man'.section_part.'/'.file_part.a:separator, 'g')
  let cat_globs = substitute(a:manpath.':', ':', '/*cat'.section_part.'/'.file_part.a:separator, 'g')
  " remove one unecessary path separator from the end
  let cat_globs = substitute(cat_globs, a:separator.'$', '', '')
  return man_globs.cat_globs
endfunction

" }}}1
" s:man_helpers_expand_path_glob {{{1

" path glob expansion to get filenames
function! s:man_helpers_expand_path_glob(path_glob, manpage_prefix)
  if empty(a:manpage_prefix)
    let manpage_part = '*'
  elseif a:manpage_prefix =~# '*$'
    " asterisk is already present
    let manpage_part = a:manpage_prefix
  else
    let manpage_part = a:manpage_prefix.'*'
  endif
  return split(globpath(a:path_glob, manpage_part, 1), '\n')
endfunction

" }}}
" s:man_helpers_strip_dirname_and_extension {{{1

" first strips the directory name from the match, then the extension
function! s:man_helpers_strip_dirname_and_extension(manpage_path)
  return s:man_helpers_strip_extension(fnamemodify(a:manpage_path, ':t'))
endfunction

" }}}
" s:man_helpers_strip_extension {{{1

" Public function so it can be used for testing.
" Check 'manpage_extension_stripping_test.vim' for example input and output
" this regex produces.
function! s:man_helpers_strip_extension(filename)
  return substitute(a:filename, '\.\(\d\a*\|n\|ntcl\)\(\.\a*\|\.bz2\)\?$', '', '')
endfunction

" }}}
" s:man_helpers_manpath {{{1

" fetches a colon separated list of paths where manpages are stored
function! s:man_helpers_manpath()
  " We don't expect manpath to change, so after first invocation it's
  " saved/cached in a script variable to speed things up on later invocations.
  if !exists('s:manpath')
    " perform a series of commands until manpath is found
    let s:manpath = $MANPATH
    if s:manpath ==# ''
      let s:manpath = system('manpath 2>/dev/null')
      if s:manpath ==# ''
        let s:manpath = system('man '.s:man_helpers_find_arg.' 2>/dev/null')
      endif
    endif
    " strip trailing newline for output from the shell
    let s:manpath = substitute(s:manpath, '\n$', '', '')
  endif
  return s:manpath
endfunction

" }}}

" vim:set ft=vim et sw=2:
