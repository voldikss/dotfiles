" ============================================================================
" FileName: coc.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" ShowDocument:
function! mycoc#showdoc() abort
  if (index(['vim','help'], &filetype) >= 0)
    let cword = expand('<cword>')
    try
      execute 'h ' . cword
    catch
      call util#show_msg('No help for ' . cword, 'error')
    endtry
  else
    call CocAction('doHover')
  endif
endfunction
