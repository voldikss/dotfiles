" ============================================================================
" FileName: man.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:source = []

function! leaderf#source#man#gather(...) abort
  if empty(s:source)
    let s:source = mancompl#complete(0, 0, 0)
  endif
  return s:source
endfunction

function! leaderf#source#man#sink(line, ...) abort
  execute 'Man ' a:line
endfunction
