" ============================================================================
" FileName: legacy.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: to implement/discard stuff
" ============================================================================

" Delete buffer and go back:
function! fn#legacy#jumpback() abort
  let buf = bufnr('%')
  let jumplst = getjumplist()
  let pos = jumplst[0][jumplst[-1]-1]
  if buf != pos.bufnr && bufexists(pos.bufnr)
    execute 'bd ' . buf
  endif
  if bufexists(pos.bufnr)
    execute pos.bufnr.'buffer ++call\ cursor('.pos.lnum.','.(pos.col+pos.coladd+1).')'
  endif
endfunction
