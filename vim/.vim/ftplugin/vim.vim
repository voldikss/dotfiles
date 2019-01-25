
setlocal foldmethod=indent
" for .vimrc
if expand('%:e')=='vimrc'
    setlocal foldmethod=marker
    setlocal foldmarker=[[[,]]]
endif
call matchadd('Todo',  '\W\zs\(Disabled\)')
call matchadd('Todo',  '\W\zs\(TODO\|Todo\|todo\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
