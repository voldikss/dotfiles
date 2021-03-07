" ============================================================================
" FileName: buffer.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:exclude_filetypes = ['floaterm', 'coc-explorer', 'vista', 'qf']

" CleanNoDisplayedBuffers: Clean buffers which are not opened in window
function! s:clean_not_displayed_buf() abort
  let visible = []
  for t in range(1, tabpagenr('$'))
    for bufnr in tabpagebuflist(t)
      call add(visible, bufnr)
    endfor
  endfor

  let tally = 0
  for bufnr in range(1, bufnr('$'))
    if index(s:exclude_filetypes, getbufvar(bufnr, '&filetype')) > -1
      continue
    endif
    if index(visible, bufnr) == -1
      try
        execute 'bwipeout!' bufnr
        let tally += 1
      catch
      endtry
    endif
  endfor
  call util#show_msg('cleaned ' . tally . ' Files')
endfunction

" CleanNoCurrentBuffers: Clean other buffers
function! s:clean_not_current_buf() abort
  let tally = 0
  for bufnr in range(1, bufnr('$'))
    if index(s:exclude_filetypes, getbufvar(bufnr, '&filetype')) > -1
      continue
    endif
    if bufnr != bufnr('%')
      try
        execute 'bwipeout!' bufnr
        let tally += 1
      catch
      endtry
    endif
  endfor
  call util#show_msg('cleaned ' . tally . ' Files')
endfunction

function! buffer#clean_buffer(bang) abort
  if a:bang
    call s:clean_not_current_buf()
  else
    call s:clean_not_displayed_buf()
  endif
endfunction
