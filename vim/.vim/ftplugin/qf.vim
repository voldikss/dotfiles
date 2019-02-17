" Snippets from vim-qf
" Credits: https://github.com/romainl/vim-qf

if exists('b:did_ftplugin')
	finish
endif

" quit vim if the last window is qf
autocmd BufEnter <buffer> if winnr('$') < 2| q | endif

let b:did_ftplugin = 1

let s:save_cpo = &cpoptions
set cpoptions&vim

let b:undo_ftplugin = 'setl fo< com< ofu<'

setlocal wrap
setlocal norelativenumber number
setlocal linebreak
setlocal nolist
setlocal cursorline
setlocal nobuflisted

nnoremap <buffer> <CR> <CR><C-w>p
nnoremap <silent><buffer> p  :call <SID>preview_file()<CR>
nnoremap <silent><buffer> q  :pclose!<CR>:quit<CR>
nnoremap <buffer> o    <CR><C-w>p
nnoremap <buffer> o    <CR><C-w>p

let b:qf_isLoc = ! empty(getloclist(0))
if b:qf_isLoc == 1
	nnoremap <buffer> O <CR>:lclose<CR>
else
	nnoremap <buffer> O <CR>:cclose<CR>
endif

function! s:preview_file()
	let winwidth = &columns
	let cur_list = b:qf_isLoc == 1 ? getloclist('.') : getqflist()
	let cur_line = getline(line('.'))
	let cur_file = fnameescape(substitute(cur_line, '|.*$', '', ''))
	if cur_line =~# '|\d\+'
		let cur_pos  = substitute(cur_line, '^\(.\{-}|\)\(\d\+\)\(.*\)', '\2', '')
		execute 'vertical pedit! +'.cur_pos.' '.cur_file
	else
		execute 'vertical pedit! '.cur_file
	endif
	wincmd P
	execute 'vert resize '.(winwidth / 2)
	wincmd p
endfunction

let &cpoptions = s:save_cpo
