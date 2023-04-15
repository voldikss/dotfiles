syn match npmrcEntry "^[^=]\+=.*$" contains=npmrcEntryKey,npmrcEntryValue,npmrcBooleanValue display
syn match npmrcEntryKey "^[^=]\+\ze=" contained containedin=npmrcEntry display
syn match npmrcEntryValue "=\zs.*$" contained containedin=npmrcEntry display
syn match npmrcBooleanValue "=\zs\%(true\|false\)$" contained containedin=npmrcEntry
syn match npmrcComment "^\s*[;#].*$" display

hi def link npmrcComment Comment
hi def link npmrcEntryKey Type
hi def link npmrcEntryValue String
hi def link npmrcBooleanValue Constant

let b:current_syntax = 'npmrc'
