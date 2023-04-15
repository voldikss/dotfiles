" ============================================================================
" FileName: x.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function! keymap#x#visual_star_search(cmdtype, ...) abort
  let temp = @"
  normal! gvy
  if !a:0 || a:1 != 'raw'
    let @" = escape(@", a:cmdtype.'\*')
  endif
  let @/ = substitute(@", '\n', '\\n', 'g')
  let @/ = substitute(@/, '\[', '\\[', 'g')
  let @/ = substitute(@/, '\~', '\\~', 'g')
endfunction

