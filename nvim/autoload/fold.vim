function! fold#fold() abort
  let origin_fdm = getwinvar(winnr(), '&foldmethod')
  setlocal foldmethod=manual
  normal! gv | zf
  call setwinvar(winnr(), '&foldmethod', origin_fdm)
endfunction
