" ============================================================================
" FileName: leaderf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! s:defered_settings() abort
  if &ft != 'leaderf'
    return
  endif
  if b:Lf_category == 'File'
    nnoremap <buffer><nowait><silent> <Space> :exec g:Lf_py "fileExplManager._previewResult(True)"<CR>
  elseif b:Lf_category == 'Rg'
    nnoremap <buffer><nowait><silent> <Space> :exec g:Lf_py "rgExplManager._previewResult(True)"<CR>
  elseif b:Lf_category == 'Buffer'
    nnoremap <buffer><nowait><silent> <Space> :exec g:Lf_py "bufExplManager._previewResult(True)"<CR>
  elseif b:Lf_category == 'Line'
    nnoremap <buffer><nowait><silent> <Space> :exec g:Lf_py "lineExplManager._previewResult(True)"<CR>
  elseif b:Lf_category == 'Mru'
    nnoremap <buffer><nowait><silent> <Space> :exec g:Lf_py "mruExplManager._previewResult(True)"<CR>
  endif
  set modifiable
endfunction

call timer_start(10, { -> s:defered_settings() })
