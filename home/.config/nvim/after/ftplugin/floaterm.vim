" ============================================================================
" FileName: floaterm.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function s:open_in_normal_window() abort
  let f = findfile(expand('<cfile>'))
  if !empty(f) && has_key(nvim_win_get_config(win_getid()), 'anchor')
    FloatermHide
    execute 'e ' . f
  endif
endfunction

function! s:floaterm_settings() abort
  hi TermCursor guifg=yellow

  setlocal nonumber
  setlocal norelativenumber

  nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
  nnoremap <silent><buffer> <Esc> <Cmd>hide<CR>

endfunction

call timer_start(100, { -> s:floaterm_settings() })
