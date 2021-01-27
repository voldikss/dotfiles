" ============================================================================
" FileName: leaderf.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: https://github.com/Yggdroot/LeaderF/issues/144#issuecomment-734322866
" ============================================================================

function! fn#leaderf#spell_accept(line,...)
  exe 'normal! "_ciw'.a:line
endfunction

function! fn#leaderf#spell_source(args)
  return spellsuggest(expand(get(a:args, "pattern", [""])[0]))
endfunction
