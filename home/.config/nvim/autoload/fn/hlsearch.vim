" ============================================================================
" FileName: hlsearch.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Info: modified from romainl/vim-cool
" ============================================================================

noremap <silent> <Plug>(StopHL) :<C-U>nohlsearch<cr>

function! fn#hlsearch#start_hl()
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
  silent call feedkeys("\<Plug>(StopHL)", 'm')
endfunction
