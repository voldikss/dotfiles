" ============================================================================
" FileName: legacy.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: to implement/discard stuff
" ============================================================================

function! JumpForward() abort
  let pattern = '^' . expand('<cword>') . '$'
  let taglist = taglist(pattern)
  if empty(taglist) && exists('g:did_coc_loaded')
    let taglist = coc#rpc#request('getTagList', [])
    let is_from_coc = v:true
  endif
  if empty(taglist)
    call util#show_msg('Tag not found', 'warning')
    return
  endif
  if len(taglist) > 2
    let candidates = map(copy(taglist), { k,v -> printf('%s. %s', k, v.filename) })
    let index = inputlist(candidates)
    let tag = taglist[index]
  else
    let tag = taglist[0]
  endif
  if !bufloaded(tag.filename)
    let bufloaded = v:false
  else
    let bufloaded = v:true
  endif
  let cmd = printf('edit %s | %s', tag.filename, tag.cmd)
  execute cmd
  call setbufvar(bufnr(tag.filename), 'close_on_ctrl_o', !bufloaded)
endfunction

function! JumpBackward() abort
  let bufnr = bufnr('%')
  let close_on_ctrl_o = getbufvar(bufnr, 'close_on_ctrl_o', v:false)
  normal! "\<C-o>"
  if close_on_ctrl_o && bufnr != bufnr('%')
    execute 'bwipeout' bufnr
  endif
endfunction
