" ============================================================================
" FileName: leaderf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! s:defered_settings() abort
  nnoremap <buffer><nowait> <silent> <Space> :exec g:Lf_py "fileExplManager._previewResult(True)"<CR>
  set modifiable
endfunction

call timer_start(10, { -> s:defered_settings() })
