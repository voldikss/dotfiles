" ============================================================================
" FileName: buffer.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:exclude_filetypes = ['floaterm', 'coc-explorer', 'vista', 'qf']

" CloseNoDisplayedBuffers: Close buffers which are not opened in window
function! s:clean_not_displayed_buf() abort
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor

  let tally = 0
  for b in range(1, bufnr('$'))
    if index(s:exclude_filetypes, getbufvar(b, '&filetype')) > -1
      continue
    endif
    if bufexists(b) && !has_key(visible, b)
      try
        execute 'bwipeout' b
        let tally += 1
      catch
      endtry
    endif
  endfor
  echom 'Closed ' . tally . ' Files'
endfunction

" CloseNoCurrentBuffers: Close other buffers
function! s:clean_not_current_buf() abort
  let tally = 0
  for b in range(1, bufnr('$'))
    if index(s:exclude_filetypes, getbufvar(b, '&filetype')) > -1
      continue
    endif
    if bufexists(b) && b != bufnr('%')
      try
        execute 'bwipeout' b
        let tally += 1
      catch
      endtry
    endif
  endfor
  echom 'Closed ' . tally . ' Files'
endfunction

function! buffer#clean_buffer(bang) abort
  if a:bang
    call s:clean_not_current_buf()
  else
    call s:clean_not_displayed_buf()
  endif
endfunction
