" ============================================================================
" FileName: cwordhi.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" TODO: https://github.com/itchyny/vim-cursorword/

"-----------------------------------------------------------------------------
" https://github.com/mg979/vim-mini-plugins/blob/master/plugin/cwordhi.vim
"-----------------------------------------------------------------------------

let g:cwordhi_enabled = 0

function! CwordhiToggle()
  " Toggle word highlight {{{1
  if g:cwordhi_enabled
    call s:cword_off()
  else
    call s:cword_on()
  endif
endfunc "}}}

function! s:cword_on()
  " Enable word highlight {{{1
  let g:cwordhi_enabled = 1
  augroup cwordhi
    au!
    au WinLeave     * call s:cword_clear()
    au InsertEnter  * call s:cword_clear()
    au InsertLeave  * call s:cword_hi()
    au CursorMoved  * call s:cword_hi()
  augroup END
  doautocmd CursorMoved
endfunc "}}}

function! s:cword_off()
  " Disable word highlight {{{1
  let g:cwordhi_enabled = 0
  call s:cword_clear()
  autocmd! cwordhi
  augroup! cwordhi
endfunc "}}}

function! s:cword_hi()
  " Reapply word highlight {{{1
  call s:cword_clear()
  if mode() != 'n'
    return
  endif
  let word = escape(expand('<cword>'), '\')
  if word =~ '\k' && matchstr(getline('.'), '\%' . col('.') . 'c.') =~ '\k'
    let word = '\C\<' . word . '\>'
    " restrict pattern matching to top and bottom visible lines
    let below = '\%>' . line('.') . 'l\%<' . line('w$') . 'l'
    let above = '\%<' . line('.') . 'l\%>' . line('w0') . 'l'
    let right = '\%>' . col('.') . 'c'
    let left  = '\%<' . max([0, col('.') - strlen(expand('<cword>'))]) . 'c'
    if hlID('VisualNOS') == 0
      hi VisualNOS guibg=#403D3D
    endif
    let h = get(g:, 'cwordhi', 'VisualNOS')
    let w:illuminated_words_below = matchadd(h, '\V' . below . word)
    let w:illuminated_words_above = matchadd(h, '\V' . above . word)
    let w:illuminated_words_right = matchadd(h, '\V' . right . word)
    let w:illuminated_words_left  = matchadd(h, '\V' . left . word)
  endif
endfunc "}}}

function! s:cword_clear()
  " Clear word highlight {{{1
  silent! call matchdelete(w:illuminated_words_above)
  silent! call matchdelete(w:illuminated_words_below)
  silent! call matchdelete(w:illuminated_words_right)
  silent! call matchdelete(w:illuminated_words_left)
endfunc "}}}

call s:cword_on()

command! CwordhiToggle call CwordhiToggle()
