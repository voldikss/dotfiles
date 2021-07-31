" for vader file, set the filetype to vim but syntax to vader
if expand('%:e') == 'vader'
  syntax clear
  runtime! syntax/vader.vim
endif

" hi! link vimUserFunc Function
" hi! link vimFunction Function
" hi! link vimFuncBody Function
