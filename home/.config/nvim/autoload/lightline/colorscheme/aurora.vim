" ========================================================================
" Description: autoload/lightline/colorscheme/aurora.vim
" Author: voldikss
" GitHub: https://github.com/voldikss/dotfiles
" ========================================================================

let s:p = {
    \ 'normal': {},
    \ 'inactive': {},
    \ 'insert': {},
    \ 'replace': {},
    \ 'visual': {},
    \ 'tabline': {}
\ }

let s:p.normal.left = [ ['#ffffff', '#005fff', 'bold'], ['#ffffff', '#00afff'] ]
let s:p.normal.middle = [ [ '#000000', '#ffffff' ] ]
let s:p.normal.right = [ ['#ffffff', '#080808'], ['#ffffff', '#262626'], ['#ffffff', '#3a3a3a'], ['#ffffff', '#4e4e4e'], ['#ffffff', '#767676'] ]

let s:p.normal.error = [ [ '#ffffff', '#ff0000' ] ]
let s:p.normal.warning = [ [ '#ffffff', '#0000ff' ] ]

let s:p.insert.left = [ ['#ffffff', '#5f00af', 'bold'], ['#ffffff', '#875fd7'] ]
let s:p.insert.middle = s:p.normal.middle
let s:p.insert.right = s:p.normal.right

let s:p.replace.left = [ ['#ffffff', '#ff0000', 'bold'], ['#ffffff', '#ff5f5f'] ]
let s:p.replace.middle = s:p.normal.middle
let s:p.replace.right = s:p.normal.right

let s:p.visual.left = [ ['#000000', '#ff5f00', 'bold'], ['#000000', '#ffaf00'] ]
let s:p.visual.middle = s:p.normal.middle
let s:p.visual.right = s:p.normal.right

let s:p.inactive.right = [ ['gray1', 'gray5'], ['gray4', 'gray1'], ['gray4', 'gray0'] ]
let s:p.inactive.left = s:p.inactive.right[1:]

let s:p.tabline.left = [ [ '#ffffff', '#00afff' ] ]
let s:p.tabline.tabsel = [ [ '#ffffff', '#005fff' ] ]
let s:p.tabline.middle = [ [ '#121212', '#ffffff' ] ]
let s:p.tabline.right = [ [ '#ffffff', '#005fff' ] ]

let g:lightline#colorscheme#aurora#palette = lightline#colorscheme#fill(s:p)
