" ============================================================================
" FileName: gdb.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! s:gdb_settings() abort
  setlocal tabstop=4
  setlocal shiftwidth=4
  setlocal softtabstop=4
  setlocal foldmethod=indent

  if !exists('b:match_words')
    let b:match_words = ''
  else
    let b:match_words .= ','
  endif
  let b:match_words .= '\<if\>:\<else\>:\<end\>,'
  let b:match_words .= '\<while\>:\<end\>,'
  let b:match_words .= '\<define\>:\<end\>,'
  let b:match_words .= '\<document\>:\<end\>'
endfunction

call timer_start(100, { -> s:gdb_settings() })
