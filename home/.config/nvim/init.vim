" vim:et:sw=2:ts=2:fdm=marker
" ============================================================================
" FileName: init.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Basic: {{{
" Disabled:
let g:loaded_netrwPlugin = 1

" HostProg:
if has('win32') || has('win64') || has('win32unix')
  let g:python3_host_prog=trim(split(system('where python'), '\n')[0])
else
  let g:python3_host_prog='/usr/bin/python3'
endif

" Encoding
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,mac,dos
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Appearance
set number norelativenumber background=dark display=lastline,uhex nowrap wrapmargin=0
set showmode shortmess+=I cmdheight=1 cmdwinheight=10 showbreak= breakindent breakindentopt=
set showmatch matchtime=0 matchpairs+=<:>,《:》,（:）,【:】,“:”,‘:’
set noshowcmd noruler rulerformat= laststatus=3
set title ruler titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=2
set nocursorline nocursorcolumn colorcolumn=9999 concealcursor=nvc conceallevel=0
set nolist synmaxcol=3000 ambiwidth=single
set nosplitbelow nosplitright nostartofline linespace=0 whichwrap=b,s scrolloff=5 sidescroll=0
set equalalways nowinfixwidth nowinfixheight winminwidth=1 winheight=3 winminheight=1
set termguicolors cpoptions+=I guioptions-=e nowarn noconfirm
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20

" Editing
set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
set smartindent autoindent shiftround shiftwidth=4 expandtab tabstop=4 smarttab softtabstop=4
set foldclose= foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
set textwidth=0 backspace=2 nrformats=hex formatoptions=cmMj nojoinspaces selectmode=mouse
set hidden autoread autowrite noautowriteall nolinebreak mouse=a modeline whichwrap=b,s,[,]
set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
set tags=./tags,../tags,../../tags,../../../tags

" Clipboard
set clipboard=unnamed

" Data files
set history=10000 noswapfile
set nospell spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set nobackup nowritebackup backupdir=$HOME/.cache/nvim/backup_dir
set undofile undolevels=1000 undodir=$HOME/.cache/nvim/undo_dir
set dictionary+=~/.config/nvim/dict/misc.dict

" Search
set wrapscan ignorecase smartcase incsearch hlsearch magic shortmess-=S
set path=.,/usr/local/include,/usr/include,**3 isfname-== isfname-=,

" Insert completion
set complete& completeopt=menuone,noinsert infercase pumheight=10 noshowfulltag shortmess+=c

" Command line
set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class
set wildchar=9 nowildmenu wildmode=longest,full wildmenu wildoptions= wildignorecase fileignorecase
set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=__pycache__,.stversions,*.spl,*.out,%*
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android
set wildignore-=*.out

" Performance
set updatetime=100 timeout timeoutlen=500 ttimeout ttimeoutlen=50 nolazyredraw

" Bell
set noerrorbells visualbell t_vb=

" neovim only
if matchstr(execute('silent version'), 'NVIM') == 'NVIM'
  set shada='20,<50,s10
  set inccommand=nosplit
  set wildoptions+=pum
  set signcolumn=yes:1
  set pumblend=0
endif

lua require('plugins')

" put this after plugxxx, do not source colorscheme twice
colorscheme srcery

" Autocmds: {{{
" autocmd CmdlineEnter * call feedkeys("\<C-p>")
" augroup ParenColor
"   autocmd!
"   autocmd VimEnter,BufWinEnter *
"         \ if index(['html', 'htmldjango', 'tex', 'mma', 'vue', 'xml'], &filetype) < 0 |
"         \ call matchadd('Constant', '\[\|\]') |
"         \ call matchadd('Identifier', '{\|}') |
"         \ call matchadd('Statement', '(\|)') |
"         \ call matchadd('PreProc', '<\|>') |
"         \ endif
" augroup END

augroup FileTypeAutocmds
  autocmd!
  autocmd FileType * set formatoptions-=cro
  autocmd FileType * syntax sync minlines=50
  autocmd BufEnter * if &bt == 'nofile' | syntax sync fromstart | endif " for `:CocCommand git.showCommit`
  autocmd FileType *
        \ call matchadd('Special', '\W\<\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)\>') |
        \ call matchadd('Special', '\W\<\(NOTE\|INFO\|IDEA\|NOTICE\|TMP\)\>') |
        \ call matchadd('Special', '\W\<\(DEBUG\|Debug\)\>') |
        \ call matchadd('Special', '\W\<\(@VOLDIKSS\|@voldikss\)\>')
augroup END

" augroup AutoSaveBuffer
"   autocmd!
"   autocmd FocusLost,InsertLeave * call file#update()
"   autocmd CursorHold * call file#update()
" augroup END

" augroup LineNumber
"   autocmd!
"   autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
"   autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
" augroup END

augroup JumpToLastPosition
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
        \ exe "normal! g'\"" |
        \ endif
augroup END

augroup AutoChangeDir
  autocmd!
  autocmd BufEnter * silent! lcd %:p:h
augroup END

augroup AutoTemplate
  autocmd!
  autocmd BufNewFile .gitignore,.npmignore,.tasks,.clang-format,Solution.cpp Template
augroup END

augroup Checktime
  autocmd!
  autocmd FocusGained * checktime
  autocmd BufEnter * checktime
augroup END

augroup CocRelatedAutocmds
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

augroup StartifyAutocmds
  autocmd!
  autocmd User Startified setlocal buflisted
augroup END

augroup ExternalOpen
  autocmd!
  autocmd BufEnter *.png,*.jpg,*.gif,*.pdf execute 'ExternalOpen'|bw
augroup END

" augroup OpenDirectory
"   autocmd!
"   autocmd BufEnter *
"         \ let g:justavalname = expand('<afile>:p') |
"         \ if isdirectory(g:justavalname) |
"           \ bdelete! |
"           \ call timer_start(100, { -> execute('FloatermNew lf ' . g:justavalname) }) |
"         \ endif
" augroup END

augroup AutoMkdir
  if exists('*mkdir')
    autocmd!
    autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')
  endif
augroup END

augroup TerminalSettings
  if has('nvim')
    autocmd!
    autocmd TermOpen *  set filetype=terminal " source after/ftplugin/terminal.vim
  endif
augroup END

augroup PreserveYankForSelectionMode
  autocmd!
  autocmd ModeChanged *:s set clipboard=
  autocmd ModeChanged s:* set clipboard=unnamed
augroup END

augroup HlGroupSettings
  autocmd!
  autocmd ColorScheme * call s:OnColorSchemeLoaded()
augroup END
function! s:OnColorSchemeLoaded() abort
  let signcolumn_bg = matchstr(execute('hi SignColumn'), 'guibg=\zs\S*')
  if empty(signcolumn_bg) | let signcolumn_bg = 'NONE' | endif
  exe 'hi GitAdd                guifg=#00FF00 guibg=' . signcolumn_bg
  exe 'hi GitModify             guifg=#00FFFF guibg=' . signcolumn_bg
  exe 'hi GitDeleteTop          guifg=#FF2222 guibg=' . signcolumn_bg
  exe 'hi GitDeleteBottom       guifg=#FF2222 guibg=' . signcolumn_bg
  exe 'hi GitDeleteTopAndBottom guifg=#FF2222 guibg=' . signcolumn_bg
  exe 'hi CocHintSign           guifg=#15aabf guibg=' . signcolumn_bg
  exe 'hi CocInfoSign           guifg=#fab005 guibg=' . signcolumn_bg
  exe 'hi CocWarningSign        guifg=#ff922b guibg=' . signcolumn_bg
  exe 'hi CocErrorSign          guifg=#ff0000 guibg=' . signcolumn_bg
  exe 'hi CursorLineNr          guibg='               . signcolumn_bg

  hi VertSplit                  guifg=gray
  hi WinSeparator                  guifg=gray
  hi CursorLineNr               guifg=orange
  " hi Normal                     guibg=#111111 guifg=#eeeeee
  hi PmenuThumb                  guifg=white guibg=white
  hi VisualNOS                  guibg=#404D3D

  let normal_bg = matchstr(execute('hi Normal'), 'guibg=\zs\S*')
  exe 'hi EndOfBuffer           guifg=' . normal_bg

  " coclist will(might) change my cursor highlight
  hi Cursor gui=reverse guifg=NONE guibg=NONE cterm=reverse
  " https://github.com/neovim/neovim/issues/12626
  " hi Cursor guibg=fg guifg=bg

  hi link CocRustTypeHint Comment
  hi link CocRustChainingHint Comment
endfunction
call s:OnColorSchemeLoaded()
" }}}

" Abbrevs: {{{
function! s:SetCommandAbbrs(from, to)
  exec 'cnoreabbrev <expr> '.a:from
        \ .' ((getcmdtype() ==# ":" && getcmdline() ==# "'.a:from.'")'
        \ .'? ("'.a:to.'") : ("'.a:from.'"))'
endfunc
call s:SetCommandAbbrs('ar', 'AsyncRun')
call s:SetCommandAbbrs('as', 'AsyncStop')
call s:SetCommandAbbrs('at', 'AsyncTask')
call s:SetCommandAbbrs('bc', 'BClean')
call s:SetCommandAbbrs('ca', 'CocAction')
call s:SetCommandAbbrs('cc', 'CocConfig')
call s:SetCommandAbbrs('cf', 'CocFix')
call s:SetCommandAbbrs('ci', 'CocInstall')
call s:SetCommandAbbrs('cl', 'CocList')
call s:SetCommandAbbrs('cm', 'CocCommand')
call s:SetCommandAbbrs('cp', 'Cppman')
call s:SetCommandAbbrs('cr', 'silent CocRestart')
call s:SetCommandAbbrs('cs', 'CocSearch')
call s:SetCommandAbbrs('cu', 'CocUninstall')
call s:SetCommandAbbrs('cup', 'CocUpdate')
call s:SetCommandAbbrs('do', 'DiffviewOpen')
call s:SetCommandAbbrs('dc', 'DiffviewClose')
call s:SetCommandAbbrs('fk', 'FloatermKill')
call s:SetCommandAbbrs('f', 'FloatermNew')
call s:SetCommandAbbrs('F', 'FloatermNew')
call s:SetCommandAbbrs('fn', 'FloatermNew')
call s:SetCommandAbbrs('Fn', 'FloatermNew')
call s:SetCommandAbbrs('fs', 'FloatermSend')
call s:SetCommandAbbrs('ft', 'FloatermToggle')
call s:SetCommandAbbrs('fu', 'FloatermUpdate')
call s:SetCommandAbbrs('gap', 'Git add -p')
call s:SetCommandAbbrs('gc', 'Git commit -v')
call s:SetCommandAbbrs('gca', 'Git commit --amend -v')
call s:SetCommandAbbrs('gco', 'Git checkout')
call s:SetCommandAbbrs('gd', 'Gvdiff')
call s:SetCommandAbbrs('gl', 'Git lg')
call s:SetCommandAbbrs('gpull', 'AsyncRun git pull')
call s:SetCommandAbbrs('gp', 'AsyncRun -silent git push -f')
call s:SetCommandAbbrs('gs', 'Gstatus')
call s:SetCommandAbbrs('l', 'Leaderf')
call s:SetCommandAbbrs('m', 'vertical Man')
call s:SetCommandAbbrs('pc', 'PlugClean')
call s:SetCommandAbbrs('pi', 'PlugInstall')
call s:SetCommandAbbrs('pu', 'PlugUpdate')
call s:SetCommandAbbrs('rn', 'Rename')
call s:SetCommandAbbrs('rm', 'Remove')
call s:SetCommandAbbrs('sl', 'CocCommand session.load default')
call s:SetCommandAbbrs('ss', 'CocCommand session.save default')
call s:SetCommandAbbrs('st', 'Startify')
call s:SetCommandAbbrs('t', 'Template')
call s:SetCommandAbbrs('W', '%!sudo tee >/dev/null %')
" }}}

" Commands: {{{
command! Format call file#format()
command! OpenFileExplorer call command#open_file_explorer()
command! CdRoot call path#cd_root()
command! PythonREPL  :FloatermNew --wintype=vsplit --width=0.5 --position=rightbelow python
command! Rename call file#rename()
command! Remove call file#remove()
command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."), v:true),"name") .
      \ "> trans<" . synIDattr(synID(line("."),col("."), v:false),"name") .
      \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."), v:true)),"name") .
      \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."), v:true)),"fg#")
command! -nargs=* Template call template#load(<q-args>)
command! -nargs=* Zeal call command#zeal(<q-args>)

command! -nargs=? Line call command#insert_line('light', <f-args>)
command! -nargs=? Bline call command#insert_line('bold', <f-args>)
command! -nargs=? Cline call command#insert_line('comment', <f-args>)

command! -nargs=+ Grep  call command#grep(<q-args>)
command! -bang    BClean call buffer#clean(<bang>0)
command! -nargs=* -complete=file Make AsyncRun -cwd=<root> -program=make @ <args>
command! -nargs=? -complete=file  ExternalOpen  call util#external_open(<q-args>)

command! -nargs=+ -complete=command Windo call command#windo(<q-args>)
command! -nargs=+ -complete=command Bufdo call command#bufdo(<q-args>)
command! -nargs=+ -complete=command Tabdo call command#tabdo(<q-args>)

command! -nargs=+ -complete=command Messages call command#tab_message(<q-args>)
command! -nargs=+ -complete=expression Echo Messages execute 'echo ' . <f-args>

command! -bang    RunTaskOnSaveChange call task#run_on_save_change(<bang>0)
command! -bang -nargs=? -complete=customlist,task#complete RunTask call task#run(<bang>0, <f-args>)

command! -nargs=? -complete=customlist,command#colors ColorScheme
      \ call command#colorscheme(<q-args>)

command! -nargs=? -complete=customlist,floaterm#cmdline#complete -range FloatermExec
      \ call myfloaterm#exec(visualmode(), <range>, <line1>, <line2>, <q-args>)
" }}}

" Mappings: {{{
let g:mapleader = ';'
noremap  H  ^
noremap  L  $
" Esc:
inoremap <C-c> <Esc>
nnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
inoremap <C-;> <Esc>
nnoremap <C-;> <Esc>
cnoremap <C-;> <Esc>
vnoremap <C-;> <Esc>
tnoremap <C-;> <C-\><C-n>
inoremap <C-[> <C-R>=keymap#i#Esc()<CR>
"cannot use noremap
nmap     M  %
omap     M  %
xmap     M  %
noremap  U  <C-R>
vnoremap <  <gv
vnoremap >  >gv
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
" PreviewAndOpen:
nnoremap <silent> gp  :<C-u>Skylight!<CR>
vnoremap <silent> gp  :Skylight!<CR>
" Edit:
nnoremap <silent> ge  :call file#refresh()<CR>
" Move:
nnoremap <silent> [[  :<C-u>call keymap#n#right_square_brackets()<CR>
nnoremap <silent> ]]  :<C-u>call keymap#n#left_square_brackets()<CR>
vnoremap <silent> [[  {j
vnoremap <silent> ]]  }k
" DiffOrChunk:
nnoremap <silent> <C-up>   :call keymap#n#prev_diff_or_chunk()<CR>
nnoremap <silent> <C-down> :call keymap#n#next_diff_or_chunk()<CR>
nnoremap <silent> gk       :call keymap#n#prev_diff_or_chunk()<CR>
nnoremap <silent> gj       :call keymap#n#next_diff_or_chunk()<CR>
" Git:
nmap <silent> gh       <Plug>(coc-git-prevconflict)
nmap <silent> gl       <Plug>(coc-git-nextconflict)
nnoremap <silent> gb       :G blame<CR>
" Jump:
nnoremap <silent> <C-j>      :<C-u>call keymap#n#goto_definition()<CR>
nnoremap <silent> <C-]>      :<C-u>call keymap#n#peek_definition()<CR>
nnoremap <silent> <C-o>      <C-o>zz
nnoremap <silent> <C-k>      :<C-u>call mycoc#showdoc()<CR>
nmap <silent> <C-w><C-j> <C-W>v<C-j>zz
" Fold:
" TODO: 做完这个
" vnoremap <silent> zf :<C-u>call fold#fold()<CR>
" Search:
nnoremap <expr>   n 'Nn'[v:searchforward].'zzzv'
nnoremap <expr>   N 'nN'[v:searchforward].'zzzv'
nnoremap <silent> * m`:keepjumps normal! *``zz<cr>
nnoremap <silent> # m`:keepjumps normal! #``zz<cr>
xnoremap <silent> * :<C-u>call keymap#x#visual_star_search('/')<CR>/<C-R>=@/<CR><CR>N
xnoremap <silent> # :<C-u>call keymap#x#visual_star_search('?')<CR>?<C-R>=@/<CR><CR>n
nnoremap <silent> <Space>n m`:normal! #<CR>
nnoremap <silent> <Leader>n m`:normal! *<CR>
" Substitute:
nnoremap ! <Plug>(RepeatRedo)
nnoremap <C-r> :%s/\<<C-r><C-w>\>/<C-r><C-w>/g \| normal! `` <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
vnoremap <C-r> :s///g \| normal! `` <Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
" TextObject:
" document
vnoremap <silent> id GoggV
onoremap <silent> id :normal vid<CR>
" line
vnoremap <silent> il g_o^
onoremap <silent> il :normal vil<CR>
vnoremap i? [*o]*
onoremap i? :<C-u>normal va?V<CR>
" url
vnoremap <silent> iu :<C-u>call textobj#url#()<CR>
onoremap <silent> iu :normal viu<CR>
" ip
vnoremap <silent> iI :<C-u>call textobj#ip#()<CR>
onoremap <silent> iI :normal viI<CR>
" number
vnoremap <silent> in :<C-u>call textobj#number#()<CR>
onoremap <silent> in :normal vin<CR>
" function argument
vnoremap <silent> ia :<C-u>call textobj#argument#(1, 1)<CR>
vnoremap <silent> aa :<C-u>call textobj#argument#(0, 1)<CR>
onoremap <silent> ia :<C-u>call textobj#argument#(1, 0)<CR>
onoremap <silent> aa :<C-u>call textobj#argument#(0, 0)<CR>
" indent
onoremap <silent> ai :<C-u>cal textobj#indent#(0, 0, 0, [line("."), line("."), col("."), col(".")])<CR>
onoremap <silent> ii :<C-u>cal textobj#indent#(1, 0, 0, [line("."), line("."), col("."), col(".")])<CR>
vnoremap <silent> ai :<C-u>cal textobj#indent#(0, 0, 1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
vnoremap <silent> ii :<C-u>cal textobj#indent#(1, 0, 1, [line("'<"), line("'>"), col("'<"), col("'>")])<CR><Esc>gv
" BufferOperation:
nnoremap <expr> <silent> <C-h>  (&filetype == 'floaterm') ? ':FloatermPrev<CR>' : ':bprev<CR>'
nnoremap <expr> <silent> <C-l>  (&filetype == 'floaterm') ? ':FloatermNext<CR>' : ':bnext<CR>'
" TabOperation:
noremap  <silent> <C-t> <Esc>:tabnew<CR>
" TextCopy:
nnoremap Y y$
nnoremap <silent> <Leader>y "+yy
vnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y "+y$
nnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>P "+P
vnoremap <silent> <Leader>p pgvy
" InsertMode: move
" do not use nore map
imap <silent> <C-k> <Up>
imap <silent> <C-j> <Down>
" snoremap <silent> <C-j> <Down>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-e> <End>
inoremap <silent> <C-o> <End><CR>
inoremap <silent> <M-o> <Esc>O
inoremap <silent> <C-d> <Esc>ddi
inoremap <silent> <C-v> <C-o>"+]p
nnoremap <silent>       <Leader>w :call buffer#write()<CR>
nnoremap <silent>       <Leader>W :noautocmd Bufdo if !empty(bufname()) && !&ro && &ma \| write \| endif<CR>
nnoremap <silent>       <M-q> q
nnoremap <silent>       <Leader>Q Q
nnoremap <silent><expr> q len(getbufinfo({'buflisted':1})) < 2 ? ":q!\<CR>" : ":bd!\<CR>"
nnoremap <silent>       Q         :qa!<CR>
nnoremap <silent> <Leader>d :<C-u>call keymap#n#safe_bdelete()<CR>
nnoremap <silent> <Leader>D :<C-u>BClean<CR>
" TerminalMode: move
" tnoremap <silent> <C-h> <Left>
" tnoremap <silent> <C-l> <Right>
" QuickMessage:
nnoremap <silent> <Leader>m :messages<CR>
nnoremap <silent> <Leader>t :Message messages<CR>
" EmptyExRepeatPreviousCommand:
nnoremap <silent> : :call keymap#n#ex_repeat_previous_command()<CR>
" CommandMode:
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
cnoremap <C-b> <C-\>ekeymap#c#CTRL_B()<CR>
cnoremap <C-f> <C-\>ekeymap#c#CTRL_F()<CR>
cnoremap <C-k> <C-\>ekeymap#c#CTRL_K()<CR>
cnoremap <C-w> <C-\>ekeymap#c#CTRL_W()<CR>
cnoremap <C-y> <Cmd>call keymap#c#CTRL_Y()<CR>
cnoremap <expr> '    keymap#c#pairs("'", "''")
cnoremap <expr> "    keymap#c#pairs('"', '""')
cnoremap <expr> <    keymap#c#pairs('<', '<>')
cnoremap <expr> (    keymap#c#pairs('(', '()')
cnoremap <expr> [    keymap#c#pairs('[', '[]')
cnoremap <expr> {    keymap#c#pairs('{', '{}')
cnoremap <expr> >    keymap#c#pairs('>', '<>')
cnoremap <expr> )    keymap#c#pairs(')', '()')
cnoremap <expr> ]    keymap#c#pairs(']', '[]')
cnoremap <expr> }    keymap#c#pairs('}', '{}')
cnoremap <expr> <BS> keymap#c#BS()
cnoremap <expr> /    keymap#c#Slash()
cnoremap <expr> \    keymap#c#BackSlash()
" TerminalMode:
tnoremap <expr> '    keymap#t#pairs("'", "''")
tnoremap <expr> "    keymap#t#pairs('"', '""')
" tnoremap <expr> <    keymap#t#pairs('<', '<>')
tnoremap <expr> (    keymap#t#pairs('(', '()')
tnoremap <expr> [    keymap#t#pairs('[', '[]')
tnoremap <expr> {    keymap#t#pairs('{', '{}')
if has('nvim')
  tnoremap <Esc>  <C-\><C-n>
endif
" WindowOperation:
if has('nvim')
  nnoremap <M-h> <C-w>h
  nnoremap <M-j> <C-w>j
  nnoremap <M-k> <C-w>k
  nnoremap <M-l> <C-w>l
  nnoremap <C-w>d :call keymap#n#quick_split()<CR>
  inoremap <M-h> <Esc><C-w>h
  inoremap <M-j> <Esc><C-w>j
  inoremap <M-k> <Esc><C-w>k
  inoremap <M-l> <Esc><C-w>l
  tnoremap <M-h> <C-\><C-n><C-w>h
  tnoremap <M-j> <C-\><C-n><C-w>j
  tnoremap <M-k> <C-\><C-n><C-w>k
  tnoremap <M-l> <C-\><C-n><C-w>l
  cnoremap <expr> <C-n>  pumvisible() ? '<Right>' : '<Down>'
  cnoremap <expr> <C-p>  pumvisible() ? '<Left>' : '<Up>'
  cnoremap <expr> <Up>   pumvisible() ? '<C-p>' : '<up>'
  cnoremap <expr> <Down> pumvisible() ? '<C-n>' : '<down>'
  inoremap <silent> <M-]> <C-R>=keymap#i#flyoutpairs(']')<CR>
  inoremap <silent> <M-}> <C-R>=keymap#i#flyoutpairs('}')<CR>
  inoremap <silent> <M-)> <C-R>=keymap#i#flyoutpairs(')')<CR>
endif
" WindowSize:
if has('nvim')
  nnoremap <M-up>    <C-w>+
  nnoremap <M-down>  <C-w>-
  nnoremap <M-left>  <C-w>5<
  nnoremap <M-right> <C-w>5>
  inoremap <M-up>    <Esc><C-w>+
  inoremap <M-down>  <Esc><C-w>-
  inoremap <M-left>  <Esc><C-w>5<
  inoremap <M-right> <Esc><C-w>5>
endif
" ClearnSearchHighlight:
if has('nvim')
  nnoremap <Esc>      <Cmd>nohlsearch<bar>echo<CR>
endif
nnoremap <silent> <BS>            :noh<bar>echo ''<CR>
" Plugins:
" TMP
noremap  <silent> <Leader>e             <Esc>:exe 'CocCommand explorer ' . getcwd()<CR>
noremap  <silent> <F2>             <Esc>:exe 'CocCommand explorer ' . getcwd()<CR>
noremap! <silent> <F2>             <Esc>:exe 'CocCommand explorer ' . getcwd()<CR>
tnoremap <silent> <F2>             <C-\><C-n>:exe 'CocCommand explorer ' . getcwd()<CR>
noremap  <silent> <F3>             <Esc>:MundoToggle<CR>
noremap! <silent> <F3>             <Esc>:MundoToggle<CR>
tnoremap <silent> <F3>             <C-\><C-n>:MundoToggle<CR>
noremap  <silent> <F4>             <Esc>:OpenFileExplorer<CR>
noremap  <silent> <F5>             <Esc>:RunTask<CR>
noremap! <silent> <F5>             <Esc>:RunTask<CR>
noremap  <silent> <Leader>x        <Esc>:RunTask<CR>
noremap  <silent> <Space>c         <Esc>:call qf#ctoggle()<CR>
noremap  <silent> <Space>l         <Esc>:call qf#ltoggle()<CR>
noremap  <silent> <F6>             <Esc>:Format<CR>
noremap  <silent> <Leader><Leader> <Esc>:Format<CR>
noremap! <silent> <F6>             <Esc>:Format<CR>
noremap  <silent> <F10>            <Esc>:Vista!!<CR>
noremap! <silent> <F10>            <Esc>:Vista!!<CR>
tnoremap <silent> <F10>            <C-\><C-n>:Vista!!<CR>
noremap  <silent> <F12>            <Esc>:FloatermToggle<CR>
noremap! <silent> <F12>            <Esc>:FloatermToggle<CR>
tnoremap <silent> <F12>            <C-\><C-n>:FloatermToggle<CR>
nnoremap <expr>   <CR>             keymap#n#CR() . "\<Esc>"
" inoremap <expr>   <CR>             keymap#i#CR()
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <expr>   <BS>             keymap#i#BS()
" }}}

" Plugin Config: {{{
" remove mapping set by vim-signature
call timer_start(100, {->execute("nunmap ']")})
call timer_start(100, {->execute("nunmap '[")})

" coc-explorer
nnoremap <silent> <Space>e :call CocAction('runCommand', 'explorer.doAction', 'closest', ['reveal:0'], [['relative', 0, 'file']])<CR>
function! s:enter_explorer()
  if &filetype == 'coc-explorer'
    " statusline
    setl statusline=coc-explorer
    call CocActionAsync('runCommand', 'explorer.doAction', 0, ['reveal:previousBuffer'])
  endif
endfunction

autocmd BufEnter * call <SID>enter_explorer()

nmap ;t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
map <C-LeftMouse> <C-i>
map <C-RightMouse> <C-o>
map <2-LeftMouse> <C-j>
map <RightMouse> <C-o>
map <MiddleMouse> <C-K>
noremap <LeftRelease> <LeftRelease>y<ESC>
