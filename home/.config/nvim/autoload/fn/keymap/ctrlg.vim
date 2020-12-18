" ============================================================================
" FileName: ctrlg.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" https://github.com/mg979/vim-mini-plugins/blob/master/plugin/ctrlg.vim
function! fn#keymap#ctrlg#() abort
  let is_win  = has("win32") || has("win64") || has("win16")
  let l = str2float(line('.').".0") / line("$") * 100
  let perc = string(float2nr(l)) . "%"

  let buf = "Buf ".bufnr('')
  let file = expand("%") == '' ? s:tr('unnamed') : expand('%')
  let mod = !&modified? '' : printf('[%s] ', s:tr('modified'))
  let lines = printf('%s / %s %s', line('.'), line('$'), s:tr('lines'))

  if !filereadable(file)
    let info = "        " . s:tr("nofile")
    let warn = 1
  else
    let info = is_win ? '' : substitute(system('ls -l "'.file.'"'), '\('.file.'\)\?\n', '', '')
    let info = "        " . info
    let warn = 0
  endif

  let all = strwidth(buf.file.perc.mod.lines) + 18 "18 is 6x3 separators
  let max = &columns - all - 20
  if len(info) > max
    let info = info[:max]."…"
  endif

  echohl Constant   | echo mod
  echohl Special    | echon buf
  echohl WarningMsg | echon "  >>  "
  echohl Directory  | echon file
  echohl WarningMsg | echon "  >>  "
  echohl Special    | echon perc
  echohl WarningMsg | echon "  >>  "
  echohl None       | echon lines
  if warn
    echohl WarningMsg
  else
    echohl Type
  endif
  echon info
  echohl None
endfunction

function! s:tr(string)
  let items = {
    \ 'en': ['Modified',   'lines', 'Not a file.', '[No Name]'],
    \ }
  let tr_dict = {
    \ 'modified': 0,
    \ 'lines': 1,
    \ 'nofile': 2,
    \ 'unnamed': 3
    \ }
  return items['en'][tr_dict[a:string]]
endfunction
