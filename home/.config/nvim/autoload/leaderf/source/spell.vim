" ============================================================================
" FileName: spell.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Origin: https://github.com/Yggdroot/LeaderF/issues/144#issuecomment-734322866
" ============================================================================

function! leaderf#source#spell#sink(line,...)
  exe 'normal! "_ciw'.a:line
endfunction

function! leaderf#source#spell#gather(args)
  return spellsuggest(expand(get(a:args, "pattern", [""])[0]))
endfunction
