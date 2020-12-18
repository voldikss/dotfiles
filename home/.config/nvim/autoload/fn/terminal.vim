" ============================================================================
" FileName: terminal.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function fn#terminal#settings() abort
  setlocal undolevels=100
  setlocal signcolumn=no 
  setlocal nobuflisted 
  setlocal nospell 
  setlocal modifiable 

  if empty(&ft) 
    setlocal filetype=terminal 
  endif

  if exists('b:asyncrun_cmd')
    setlocal number
  endif

  nmap <silent><buffer> q :q<CR> 
endfunction
