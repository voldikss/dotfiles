
syn match npmDebugLogID "^\d\+" display
syn match npmDebugLogInfo "\%(^\d\+ \)\@<=\%(info\|http\)\>" display
syn match npmDebugLogVerbose "\%(^\d\+ \)\@<=verbose\>" display
syn match npmDebugLogError "\%(^\d\+ \)\@<=error\>" display
syn match npmDebugLogStack "\%(^\d\+ \h\w\+ \)\@<=stack .\+$" display
syn region npmDebugLogString start="\s\zs'" skip="\\'" end="'" display
syn region npmDebugLogCmd start="`" skip="\\`" end="`" display

hi def link npmDebugLogID PreProc
hi def link npmDebugLogInfo Statement
hi def link npmDebugLogVerbose Type
hi def link npmDebugLogError Error
hi def link npmDebugLogStack ErrorMsg
hi def link npmDebugLogString String
hi def link npmDebugLogCmd String

let b:current_syntax = 'npm-debug-log'
