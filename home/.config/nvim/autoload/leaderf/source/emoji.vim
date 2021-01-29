" ============================================================================
" FileName: emoji.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Origin: https://github.com/yazgoo/unicodemoji/blob/master/plugin/unicodemoji.vim
" ============================================================================

let s:path = fnamemodify(resolve(expand('<sfile>:p')), ':h')

function! leaderf#source#emoji#sink(line,...)
  call feedkeys("i")
  call feedkeys(strcharpart(a:line, 0, 1))
  call feedkeys(" ")
  call feedkeys("\<Esc>")
endfunction

function! leaderf#source#emoji#gather(args)
  return systemlist(s:path . '/emoji --no-fzf')
endfunction
