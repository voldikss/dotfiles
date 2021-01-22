" ============================================================================
" FileName: floaterm.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! fn#floaterm#watch_callback(job, data, event) abort
  if a:event == 'stdout'
    if match(a:data, '\CERROR') > -1
      let g:asyncrun_status = 'yarn watch error'
    else
      let g:asyncrun_status = 'yarn watching'
    endif
  elseif a:event == 'stderr'
    let g:asyncrun_status = ''
  else
    let g:asyncrun_status = ''
  endif
endfunction
