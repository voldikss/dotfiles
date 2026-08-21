" ============================================================================
" FileName: floaterm.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

function s:open_in_normal_window() abort
  let lnumpat = '\(:\|(\||\)\zs\d\+\ze'
  let pattern = expand('<cfile>')
  let lnumstr = matchstr(getline('.'), pattern . lnumpat)
  let filename = substitute(pattern, '^\zs\(\~\|\$HOME\)', $HOME, '')
  let lnum = empty(lnumstr) ? -1 : str2nr(lnumstr)

  let f = findfile(filename)
  if !empty(f) && has_key(nvim_win_get_config(win_getid()), 'anchor')
    FloatermHide
    silent! execute printf('edit %s | %s',
          \ f,
          \ lnum > -1 ? lnum : 0
          \ )
  endif
endfunction

hi TermCursor guifg=yellow

setlocal nonumber
setlocal norelativenumber

nnoremap <silent><buffer> gf :call <SID>open_in_normal_window()<CR>
nnoremap <silent><buffer> <Esc> <Cmd>hide<CR>

" simple gdb TUI highlight
if type(b:floaterm_cmd) == v:t_string && b:floaterm_cmd == 'gdb'
  call timer_start(100, {->execute('set syntax=nvimgdb')})
endif
