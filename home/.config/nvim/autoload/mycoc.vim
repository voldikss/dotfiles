" ============================================================================
" FileName: coc.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" ShowDocument:
function! mycoc#showdoc() abort
  if (index(['vim','help'], &filetype) >= 0)
    try
      execute 'h '.expand('<cword>')
    catch
      echom 'No help for ' . expand('<cword>')
    endtry
  else
    call CocAction('doHover')
  endif
endfunction
