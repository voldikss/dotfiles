" ============================================================================
" FileName: buffer.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:exclude_filetypes = ['floaterm', 'coc-explorer', 'vista', 'qf', 'leaderf']

function! s:should_clean(bufnr) abort
  if index(s:exclude_filetypes, getbufvar(a:bufnr, '&filetype')) > -1
    return v:false
  else
    let winid = bufwinid(a:bufnr)
    if winid >= 0 && getwinvar(winid, 'treesitter_context', v:false) == v:true
      return v:false
    endif
  endif
  return v:true
endfunction

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
    if !s:should_clean(bufnr)
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
    if !s:should_clean(bufnr)
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

function! buffer#clean(bang) abort
  if a:bang
    call s:clean_not_current_buf()
  else
    call s:clean_not_displayed_buf()
  endif
endfunction

function! buffer#write() abort
  if empty(bufname()) 
    let filename = strftime('%Y%m%d%I%M%S')
    execute printf('write /tmp/nvim/%s.txt', filename)
  else
    write
  endif
endfunction
