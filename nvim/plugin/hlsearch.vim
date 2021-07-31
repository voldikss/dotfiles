" ============================================================================
" FileName: hlsearch.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: modified from romainl/vim-cool
" ============================================================================

function! s:start_hl()
  if !v:hlsearch || mode() isnot 'n'
    return
  endif
  let [pos, rpos] = [winsaveview(), getpos('.')]
  silent! exe "keepjumps go".(line2byte('.')+col('.')-(v:searchforward ? 2 : 0))
  try
    silent keepjumps norm! n
    if getpos('.') != rpos
      call <SID>stop_hl()
    endif
  catch
    return
  finally
    call winrestview(pos)
  endtry
endfunction

function! s:stop_hl()
  if !v:hlsearch || mode() isnot 'n'
    return
  endif
  silent call feedkeys("\<Plug>(stop-hl)", 'm')
endfunction

augroup auto-nohlsearch
  autocmd!
  autocmd CursorMoved * call s:start_hl()
augroup END

noremap <silent> <Plug>(stop-hl) :<C-U>nohlsearch<cr>
