" The command that starts debugging, e.g. ":Termdebug vim".
" To end type "quit" in the gdb window.
command -nargs=* -complete=file -bang Termdebug call termdebug#StartDebug(<bang>0, <f-args>)
command -nargs=+ -complete=file -bang TermdebugCommand call termdebug#StartDebugCommand(<bang>0, <f-args>)
