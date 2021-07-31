" vim:et:sw=2:ts=2:fdm=marker
" ============================================================================
" FileName: init.lite.vim
" Description: for large size file
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

" Basic: {{{
" Disabled:
let g:loaded_netrwPlugin = 1

" HostProg:
if has('win32') || has('win64') || has('win32unix')
  let g:python3_host_prog='D:\Applications\Python39\python.exe'
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
set noshowcmd noruler rulerformat= laststatus=2
set title ruler titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=2
set cursorline nocursorcolumn colorcolumn= concealcursor=nvc conceallevel=0
set list listchars=tab:\|\ ,extends:>,precedes:< synmaxcol=3000 ambiwidth=single
set nosplitbelow nosplitright nostartofline linespace=0 whichwrap=b,s scrolloff=5 sidescroll=0
set equalalways nowinfixwidth nowinfixheight winminwidth=3 winheight=3 winminheight=3
set termguicolors cpoptions+=I guioptions-=e nowarn noconfirm
set guicursor=n-v-c-sm:block,i-ci-ve:block,r-cr-o:hor20

" Editing
set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
set smartindent autoindent shiftround shiftwidth=4 expandtab tabstop=4 smarttab softtabstop=4
set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
set textwidth=0 backspace=2 nrformats=hex formatoptions=cmMj nojoinspaces selectmode=mouse
set hidden autoread autowrite noautowriteall nolinebreak mouse=a modeline whichwrap=b,s,<,>,[,]
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
if matchstr(execute('silent version'), 'NVIM v\zs[^\n-]*') >= '0.4.0'
  set shada='20,<50,s10
  set inccommand=nosplit
  set wildoptions+=pum
  set signcolumn=yes:1
  set pumblend=0
endif

" }}}

" " Plugin: {{{
" call plug#begin('~/.cache/nvim/plugged')
" " Languages
" if has('nvim')
" Plug 'nvim-treesitter/nvim-treesitter'
" Plug 'sindrets/diffview.nvim'
" Plug 'nacro90/numb.nvim'
" endif
" Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh', 'on': 'GdbStart'} " use to debug nvim itself
" " Plug 'fatih/vim-go', {'for': 'go'}
" Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown', 'do': 'cd app && npm install'}
" Plug 'lervag/vimtex'
" Plug 'posva/vim-vue', {'for': 'vue'}
" Plug 'jparise/vim-graphql'
" Plug 'rust-lang/rust.vim', {'for': 'rust'}
" Plug 'tpope/vim-dadbod', {'for': ['sql', 'mysql']}
" " Completion
" if !exists('g:vscode') " TODO: use packer.nvim's `cond`
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" endif
" " Style
" Plug 'Yggdroot/indentLine'
" Plug 'kshenoy/vim-signature'
" Plug 'lukas-reineke/indent-blankline.nvim' " can not exclude startify on the first :Startify
" Plug 'guns/xterm-color-table.vim', {'on': 'XtermColorTable'}
" Plug 'itchyny/lightline.vim'
" Plug 'mengelbrecht/lightline-bufferline'
" Plug 'mhinz/vim-startify', {'on': 'Startify'}
" Plug 'ryanoasis/vim-devicons'
" Plug 'itchyny/vim-cursorword'
" " Git
" Plug 'tpope/vim-fugitive'
" Plug 'tpope/vim-git'
" " Others
" " Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
" " Plug 'brglng/vim-im-select'
" " Plug 'puremourning/vimspector'
" Plug 'phaazon/hop.nvim', {'on': 'HopWord'}
" Plug 'yangmillstheory/vim-snipe', {'on': ['<Plug>(snipe-f)', '<Plug>(snipe-F)']}
" Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
" Plug 'andrewradev/sideways.vim'
" Plug 'foosoft/vim-argwrap', {'on': '<Plug>(ArgWrapToggle)'}
" Plug 'junegunn/vader.vim'
" Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}
" Plug 'junegunn/vim-peekaboo'
" Plug 'liuchengxu/vista.vim'
" " Plug 'liuchengxu/vim-clap'
" Plug 'matze/vim-move'
" Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
" Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop'] }
" Plug 'skywind3000/vim-cppman', {'on': 'Cppman'}
" Plug 'skywind3000/asynctasks.vim'
" Plug 'skywind3000/vim-dict'
" Plug 'tommcdo/vim-exchange'
" Plug 'tomtom/tcomment_vim'
" Plug 'tpope/vim-repeat'
" Plug 'tpope/vim-surround'
" Plug 'voldikss/vim-browser-search'
" Plug 'voldikss/vim-skylight'
" Plug 'voldikss/vim-codelf'
" Plug 'voldikss/vim-floaterm'
" Plug 'voldikss/vim-translator'
" Plug 'voldikss/LeaderF-emoji'
" Plug 'wellle/targets.vim'
" Plug 'yianwillis/vimcdoc'
" call plug#end()
" " }}}

" put this after plugxxx, do not source colorscheme twice
colorscheme gruvbox

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
  autocmd FileType *
        \ call matchadd('Special', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)\ze') |
        \ call matchadd('Special', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\|TMP\)\ze') |
        \ call matchadd('Special', '\W\zs\(DEBUG\|Debug\)\ze') |
        \ call matchadd('Special', '\W\zs\(@VOLDIKSS\|@voldikss\)\ze')
augroup END

augroup AutoSaveBuffer
  autocmd!
  " autocmd FocusLost,InsertLeave * call file#update()
  autocmd CursorHold * call file#update()
augroup END

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

augroup OpenDirectory
  autocmd!
  autocmd BufEnter *
        \ let g:justavalname = expand('<afile>:p') |
        \ if isdirectory(g:justavalname) |
          \ bdelete! |
          \ call timer_start(100, { -> execute('FloatermNew lf ' . g:justavalname) }) |
        \ endif
augroup END

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

  hi VertSplit                  guifg=cyan
  " hi CocFloating                guibg=blue
  hi CursorLineNr               guifg=orange
  " hi Normal                     guibg=#111111 guifg=#eeeeee
  hi PmenuThumb                  guifg=white guibg=white
  hi VisualNOS                  guibg=#404D3D

  let normal_bg = matchstr(execute('hi Normal'), 'guibg=\zs\S*')
  exe 'hi EndOfBuffer           guifg=' . normal_bg

  " coclist will(might) change my cursor highlight
  hi Cursor gui=reverse guifg=NONE guibg=NONE
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
call s:SetCommandAbbrs('gp', 'AsyncRun -silent git push')
call s:SetCommandAbbrs('Gpush', 'AsyncRun -silent git push')
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
command! AutoFormat call file#autoformat()
command! OpenFileExplorer call command#open_file_explorer()
command! CdRoot call path#cd_root()
command! PythonREPL  :FloatermNew --wintype=vsplit --width=0.5 --position=rightbelow python
command! Rename call file#rename()
command! Remove call file#remove()
command! Wcolor echo "hi<" . synIDattr(synID(line("."),col("."), v:true),"name") .
      \ "> trans<" . synIDattr(synID(line("."),col("."), v:false),"name") .
      \ "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."), v:true)),"name") .
      \ "> fg:" . synIDattr(synIDtrans(synID(line("."),col("."), v:true)),"fg#")
command! -nargs=* Template call template#TLoad(<q-args>)
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
command! -nargs=? -complete=customlist,task#complete RunTask call task#run(<f-args>)

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
" Jump:
nnoremap <silent> <C-j>      :<C-u>call keymap#n#goto_definition()<CR>
nnoremap <silent> <C-o>      <C-o>zz
nnoremap <silent> <C-k>      :<C-u>call mycoc#showdoc()<CR>
nmap <silent> <C-w><C-j> <C-W>v<C-j>zz
" Search:
nnoremap <expr>   n 'Nn'[v:searchforward].'zzzv'
nnoremap <expr>   N 'nN'[v:searchforward].'zzzv'
nnoremap <silent> * m`:keepjumps normal! *``zz<cr>
nnoremap <silent> # m`:keepjumps normal! #``zz<cr>
xnoremap <silent> * :<C-u>call keymap#x#visual_star_search('/')<CR>/<C-R>=@/<CR><CR>N
xnoremap <silent> # :<C-u>call keymap#x#visual_star_search('?')<CR>?<C-R>=@/<CR><CR>n
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
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-j> <Down>
" snoremap <silent> <C-j> <Down>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-e> <End>
inoremap <silent> <C-o> <End><CR>
inoremap <silent> <M-o> <Esc>O
inoremap <silent> <C-d> <Esc>ddi
inoremap <silent> <C-v> <C-o>"+]p
nnoremap <silent>       <Leader>w :write<CR>
nnoremap <silent>       <Leader>W :noautocmd Bufdo if !empty(bufname()) && !&ro && &ma \| write \| endif<CR>
nnoremap <silent>       <M-q> q
nnoremap <silent>       <Leader>Q Q
nnoremap <silent><expr> q len(getbufinfo({'buflisted':1})) < 2 ? ":q!\<CR>" : ":bd!\<CR>"
nnoremap <silent>       Q         :qa!<CR>
nnoremap <silent> <Leader>d :<C-u>call keymap#n#safe_bdelete()<CR>
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
if has('win32') || has('win64')
  nnoremap <silent> <Leader>n :vert term<CR>
  nnoremap <silent> ,n        :term<CR>
else
  nnoremap <silent> <Leader>n :vsplit term://zsh<CR>
  nnoremap <silent> ,n        :edit term://zsh<CR>
endif
" WindowOperation:
if has('nvim')
  nnoremap <M-h> <C-w>h
  nnoremap <M-j> <C-w>j
  nnoremap <M-k> <C-w>k
  nnoremap <M-l> <C-w>l
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
noremap  <silent> <Leader><Space>  <Esc>:call quickfix#toggle()<CR>
noremap  <silent> <F6>             <Esc>:AutoFormat<CR>
noremap  <silent> <Leader><Leader> <Esc>:AutoFormat<CR>
noremap! <silent> <F6>             <Esc>:AutoFormat<CR>
noremap  <silent> <F10>            <Esc>:Vista!!<CR>
noremap! <silent> <F10>            <Esc>:Vista!!<CR>
tnoremap <silent> <F10>            <C-\><C-n>:Vista!!<CR>
noremap  <silent> <F12>            <Esc>:FloatermToggle<CR>
noremap! <silent> <F12>            <Esc>:FloatermToggle<CR>
tnoremap <silent> <F12>            <C-\><C-n>:FloatermToggle<CR>
nnoremap <expr>   <CR>             keymap#n#CR() . "\<Esc>"
inoremap <expr>   <CR>             keymap#i#CR()
inoremap <expr>   <BS>             keymap#i#BS()
" }}}

" " Plugin Config: {{{
" " lervag/vimtex
" let g:tex_flavor='latex'
" let g:vimtex_quickfix_mode = 0
" let g:vimtex_view_method='general'
" " let g:vimtex_view_method='zathura'
" " TODO:
" " let g:vimtex_view_general_viewer = 'okular'
" " let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" " let g:vimtex_view_general_options_latexmk = '--unique'
" let g:vimtex_mappings_enabled = 0
" let g:vimtex_fold_enabled = 1
" let g:vimtex_quickfix_open_on_warning = 0
" let g:vimtex_compiler_method = 'latexmk'
" let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
" let g:vimtex_compiler_latexrun_engines = {'_': 'xelatex'}
" " iamcco/markdown-preview.nvim
" let g:mkdp_auto_close = 0
" " neoclide/coc.nvim
" let g:coc_data_home = '~/.config/coc'
" nnoremap <silent><nowait> <C-b> :call keymap#n#scroll_win(0)<CR>
" nnoremap <silent><nowait> <C-f> :call keymap#n#scroll_win(1)<CR>
" inoremap <silent><nowait><expr> <C-f>
"       \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" :
"       \ "<C-r>=keymap#exec('normal! w')<CR>"
" inoremap <silent><nowait><expr> <C-b>
"       \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :
"       \ "<C-r>=keymap#exec('normal! b')<CR>"
" nnoremap <expr> <silent> <C-c> <SID>select_current_word_and_go_next()
" function! s:select_current_word_and_go_next()
"   if !get(g:, 'coc_cursors_activated', 0)
"     return "\<Plug>(coc-cursors-word)"
"   endif
"   " based on coc readme, this has been modified
"   " because I have mapped * to m`:keepjumps normal! *``zz<cr>
"   return "*n\<Plug>(coc-cursors-word):nohlsearch\<CR>"
" endfunc
" nmap     <silent> <M-n>      <Plug>(coc-diagnostic-next)
" nmap     <silent> <M-p>      <Plug>(coc-diagnostic-prev)
" nnoremap <silent> cl         :<C-u>CocList<CR>
" nnoremap <silent> <Leader>cs :<C-u>CocSearch <C-r><C-w><CR>
" nmap     <silent> <Leader>cf <Plug>(coc-fix-current)
" nmap     <silent> <Leader>cd <Plug>(coc-definition)
" nmap     <silent> <Leader>cr <Plug>(coc-refactor)
" nmap     <silent> <Leader>ci <Plug>(coc-implementation)
" nmap     <silent> <Leader>rn <Plug>(coc-rename)
" nmap     <silent> <Leader>rf <Plug>(coc-references-used)
" nnoremap <silent> <Leader>rs :<C-u>CocRestart<CR>
" xmap ic <Plug>(coc-classobj-a)
" omap ic <Plug>(coc-classobj-a)
" xmap if <Plug>(coc-funcobj-a)
" omap if <Plug>(coc-funcobj-a)
" omap ig <Plug>(coc-git-chunk-inner)
" xmap ig <Plug>(coc-git-chunk-inner)
" " coc-git
" nnoremap <silent> gs  :CocCommand git.chunkStage<CR>
" nnoremap <silent> go  :CocCommand git.browserOpen<CR>
" nnoremap <silent> gd  :CocCommand git.chunkInfo<CR>
" nnoremap <silent> gm  :CocCommand git.showCommit<CR>
" nnoremap <silent> gw  :call file#refresh()<CR>:Gw<CR>:call file#refresh()<CR>
" nnoremap <silent> gW  :AsyncRun -cwd=<root> -silent=1 git add .<CR>
" nnoremap <silent> gca :Git commit --amend -v<CR>
" nnoremap <silent> gcm :Git commit -v<CR>
" nnoremap <silent> gcu :CocCommand git.chunkUndo<CR>
" " coc-snippets
" " 不要改动
" inoremap <silent><expr> <TAB>
"       \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
"       \ <SID>check_back_space() ? "\<TAB>" :
"       \ coc#refresh()
" function! s:check_back_space() abort
"   let col = col('.') - 1
"   return !col || getline('.')[col - 1]  =~# '\s'
" endfunction
" let g:coc_snippet_next = '<Tab>'
" let g:coc_snippet_prev = '<S-Tab>'
" " coc extensions
" let g:coc_global_extensions = [
"       \ 'coc-browser',
"       \ 'coc-clangd',
"       \ 'coc-clang-format-style-options',
"       \ 'coc-clock',
"       \ 'coc-cmake',
"       \ 'coc-css',
"       \ 'coc-diagnostic',
"       \ 'coc-dictionary',
"       \ 'coc-ecdict',
"       \ 'coc-emmet',
"       \ 'coc-emoji',
"       \ 'coc-eslint',
"       \ 'coc-explorer',
"       \ 'coc-floaterm',
"       \ 'coc-gist',
"       \ 'coc-git',
"       \ 'coc-highlight',
"       \ 'coc-html',
"       \ 'coc-java',
"       \ 'coc-json',
"       \ 'coc-dash-complete',
"       \ 'coc-just-complete',
"       \ 'coc-leetcode',
"       \ 'coc-lists',
"       \ 'coc-marketplace',
"       \ 'coc-pairs',
"       \ 'coc-prettier',
"       \ 'coc-pyright',
"       \ 'coc-rust-analyzer',
"       \ 'coc-syntax',
"       \ 'coc-snippets',
"       \ 'coc-tag',
"       \ 'coc-tasks',
"       \ 'coc-todolist',
"       \ 'coc-translator',
"       \ 'coc-tsserver',
"       \ 'coc-vimlsp',
"       \ 'coc-vimtex',
"       \ 'coc-word',
"       \ 'coc-yank'
"       \ ]
" " Yggdroot/indentLine
" let g:indentLine_char = '│'
" let g:indentLine_enabled = 1
" let g:indentLine_color_term = 238
" let g:indentLine_fileTypeExclude = [
"       \ 'coc-explorer',
"       \ 'codi',
"       \ 'floaterm',
"       \ 'help',
"       \ 'json',
"       \ 'jsonc',
"       \ 'man',
"       \ 'startify',
"       \ 'translator',
"       \ 'vista',
"       \ ]
" " lukas-reineke/indent-blankline.nvim
" let g:indent_blankline_char_highlight = 'Delimiter'
" " mhinz/vim-startify
" let g:webdevicons_enable_startify = 1
" nnoremap <silent> <Space><Space> <Esc>:Startify<CR>
" function! s:stdpath_config() abort
"   if has('nvim')
"     return stdpath('config')
"   else
"     return has('unix') ? '~/.config/nvim' : 'C:\Users\dyzh\AppData\Local\nvim'
"   endif
" endfunction
" let g:startify_bookmarks = [
"       \ {'c': <SID>stdpath_config() . '/coc-settings.json'},
"       \ {'v': <SID>stdpath_config() . '/init.vim'}
"       \ ]
" let g:startify_files_number = 8
" let g:startify_padding_left = 15
" if has('nvim')
"   highlight StartifyHeader guifg=#FF00FF
"   highlight StartifyNumber guifg=#00FF00
"   highlight StartifyPath   guifg=#00AFFF
"   highlight StartifySlash  guifg=#DF875F
" endif
" " itchyny/vim-cursorword
" let g:cursorword_highlight = 0
" hi CursorWord0 guibg=#404D3D
" hi link CursorWord1 CursorLine
" " itchyny/lightline.vim
" let g:lightline = {
"   \ 'colorscheme': 'srcery',
"   \ 'active': {
"     \ 'left': [
"       \ ['mode'],
"       \ ['fugitive', 'readonly'],
"       \ ['active_filename']
"     \ ],
"     \ 'right': [
"       \ ['lineinfo'],
"       \ ['percent'],
"       \ ['cocstatus', 'asyncrun_status', 'floaterm_exec_status'],
"       \ ['fileformat', 'fileencoding'],
"       \ ['filetype'],
"       \ ['codelf_status'],
"       \ ['translator_status'],
"     \ ]
"   \ },
"   \ 'inactive': {
"     \ 'left': [['inactive_filename']],
"     \ 'right': []
"   \ },
"   \ 'tabline': {
"     \ 'left': [['vim_logo', 'buffers']],
"     \ 'right': [['close']],
"     \ 'subseparator': {
"       \ 'left': '│',
"       \ 'right': '│'
"     \ }
"   \ },
"   \ 'component': {
"     \ 'lineinfo': ' %l,%-v',
"     \ 'percent': '%p%%',
"     \ 'close': '%{has("nvim") ? " NVIM " : " VIM "}',
"     \ 'vim_logo': "#"
"   \ },
"   \ 'component_function': {
"     \ 'asyncrun_status': 'mylightline#AsyncRunStatus',
"     \ 'floaterm_exec_status': 'mylightline#FloatermExecStatus',
"     \ 'codelf_status': 'mylightline#Codelf_Status',
"     \ 'translator_status': 'mylightline#Translator_Status',
"     \ 'mode': 'mylightline#Mode',
"     \ 'fugitive': 'mylightline#GitBranch',
"     \ 'cocstatus': 'coc#status',
"     \ 'readonly': 'mylightline#ReadOnly',
"     \ 'fileformat': 'mylightline#FileFormat',
"     \ 'fileencoding': 'mylightline#FileEncoding',
"     \ 'filetype': 'mylightline#FileType',
"     \ 'active_filename': 'mylightline#ActiveFileinfo',
"     \ 'inactive_filename': 'mylightline#InactiveFileinfo',
"   \ },
"   \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
"   \ 'component_type': { 'buffers': 'tabsel' },
"   \ 'subseparator': {
"     \ 'left': '│',
"     \ 'right': '│'
"   \ }
" \ }
" " mengelbrecht/lightline-bufferline
" let g:lightline#bufferline#unnamed = '[No Name]'
" let g:lightline#bufferline#filename_modifier = ':t'
" let g:lightline#bufferline#enable_devicons = 1
" let g:lightline#bufferline#unicode_symbols = 1
" let g:lightline#bufferline#show_number  = 3
" let g:lightline#bufferline#number_map = {
"       \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
"       \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
"       \ }
" nmap <Leader>1 <Plug>lightline#bufferline#go(1)
" nmap <Leader>2 <Plug>lightline#bufferline#go(2)
" nmap <Leader>3 <Plug>lightline#bufferline#go(3)
" nmap <Leader>4 <Plug>lightline#bufferline#go(4)
" nmap <Leader>5 <Plug>lightline#bufferline#go(5)
" nmap <Leader>6 <Plug>lightline#bufferline#go(6)
" nmap <Leader>7 <Plug>lightline#bufferline#go(7)
" nmap <Leader>8 <Plug>lightline#bufferline#go(8)
" nmap <Leader>9 <Plug>lightline#bufferline#go(9)
" nmap <Leader>0 <Plug>lightline#bufferline#go(10)
" " skywind3000/asyncrun.vim
" let g:asyncrun_status = ''  " asyncrun is lazy loaded
" let g:asyncrun_open = 9
" let g:asyncrun_rootmarks = ['.git', '.root', '.tasks']
" " skywind3000/asynctasks.vim
" let g:asynctasks_term_pos = 'bottom'
" let g:asynctasks_term_reuse = 0
" let g:asynctasks_term_rows = 8
" " Yggdroot/LeaderF
" let g:Lf_Extensions = get(g:, 'Lf_Extensions', {})
" let g:Lf_Extensions.spell = {
"   \ "source": "leaderf#source#spell#gather",
"   \ "arguments" : [{"name":["pattern"], "nargs":1}],
"   \ "accept": "leaderf#source#spell#sink"
" \ }
" let g:Lf_Extensions.man = {
"   \ "source": "leaderf#source#man#gather",
"   \ "accept": "leaderf#source#man#sink"
" \ }
" nnoremap z= :Leaderf spell <cword> <CR>
" nnoremap <silent> <Leader>fb :Leaderf buffer --all<CR>
" nnoremap <silent> <Leader>fc :Leaderf! --recall --stayOpen<CR>
" " nnoremap <silent> <Leader>ff :<C-U><C-R>=printf("Leaderf file %s", path#get_root())<CR><CR>
" nnoremap <silent> <Leader>ff :Leaderf file<CR>
" nnoremap <silent> <Leader>fg :Leaderf rg<CR>
" nnoremap <silent> <Leader>fh :Leaderf cmdHistory<CR>
" nnoremap <silent> <Leader>fl :Leaderf line --all<CR>
" nnoremap <silent> <Leader>fm :Leaderf mru<CR>
" nnoremap <silent> <Leader>ft :Leaderf bufTag<CR>
" nnoremap <silent> <Leader>fu :Leaderf function<CR>
" nnoremap <silent> <Leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" nnoremap <silent> <Leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" nnoremap <silent> <Leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" nnoremap <silent> <Leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
" let g:Lf_CacheDirectory       = expand('~/.cache/nvim')
" let g:Lf_CommandMap = {
"   \ '<Up>': ['<C-p>'],
"   \ '<Down>': ['<C-n>'],
"   \ '<Home>': ['<C-A>']
" \ }
" let g:Lf_Ctags                = "ctags"
" let g:Lf_DefaultExternalTool = ""
" let g:Lf_FilerShowDevIcons = 1
" let g:Lf_GtagsAutoGenerate = 0
" let g:Lf_Gtagslabel = 'native-pygments'
" let g:Lf_HideHelp             = 1
" let g:Lf_IndexTimeLimit       = 10
" let g:Lf_MruFileExclude = ['*.so','*.py[c0]','*.exe','*.sw?']
" let g:Lf_PreviewInPopup = 1
" let g:Lf_PreviewResult        = {'Function':0, 'BufTag':0}
" let g:Lf_RgConfig = [
"       \ "--glob=!OmegaOptions.bak",
"       \ "--glob=!logs",
"       \ "--glob=!logs-meta",
"       \ "--glob=!node_modules",
"       \ "--glob=!lib/*.js",
"       \ "--glob=!yarn.lock",
"       \ "--glob=!package-lock.json",
"       \ "--glob=!target",
"       \ "--glob=!tags",
"       \ "--glob=!build",
"       \ "--glob=!.git",
"       \ "--glob=!.ccls-cache",
"       \ "--max-columns=150",
"       \ "--hidden"
"       \ ]
" let g:Lf_RootMarkers    = [
"       \ '.project',
"       \ '.svn',
"       \ '.git',
"       \ '.idea',
"       \ ]
" let g:Lf_ShowHidden           = 1
" let g:Lf_ShowRelativePath     = 1
" let g:Lf_StlColorscheme = 'gruvbox_material'
" let g:Lf_StlSeparator   = {'left': '', 'right': '', 'font': ''}
" let g:Lf_UseVersionControlTool = 0
" let g:Lf_WildIgnore = {
"   \ 'dir': [
"     \ '.svn',
"     \ '.git',
"     \ '.hg',
"     \ '.cache',
"     \ '.idea',
"     \ '.ccls-cache',
"     \ '.android',
"     \ '.gradle',
"     \ '.IntelliJIdea*',
"     \ 'node_modules',
"     \ 'build'
"   \ ],
"   \ 'file': [
"     \ '*.sw?',
"     \ '~$*',
"     \ '*.exe',
"     \ '*.o',
"     \ '*.so',
"     \ '*.py[co]'
"   \ ]
" \ }
" let g:Lf_WindowHeight = 0.4
" let g:Lf_WorkingDirectoryMode = 'Ac'
" " voldikss/vim-browser-search
" nmap <silent> <Leader>s <Plug>SearchNormal
" vmap <silent> <Leader>s <Plug>SearchVisual
" let g:browser_search_engines = {
"   \ 'qt': 'https://doc.qt.io/qt-5/search-results.html?q=%s',
"   \ 'cppreference':'https://en.cppreference.com/mwiki/index.php?title=Special:Search&search=%s'
" \ }
" " voldikss/vim-translator
" nmap <silent>    ,t        <Plug>Translate
" nmap <silent>    ,w        <Plug>TranslateW
" nmap <silent>    ,r        <Plug>TranslateR
" vmap <silent>    ,t        <Plug>TranslateV
" vmap <silent>    ,w        <Plug>TranslateWV
" vmap <silent>    ,r        <Plug>TranslateRV
" let g:translator_status = ''
" let g:translator_history_enable = 1
" let g:translator_default_engines = ['bing', 'google', 'haici', 'youdao']
" let g:translator_window_max_height = 0.7
" let g:translator_window_max_width = 0.7
" " voldikss/vim-floaterm
" let g:floaterm_exec_status = ''
" let g:floaterm_title = 'floaterm ($1|$2)'
" let g:floaterm_width = 0.65
" let g:floaterm_height = 0.65
" let g:floaterm_position = 'center'
" let g:floaterm_opener = 'edit'
" let g:floaterm_autoclose = 2
" let g:floaterm_autohide = v:true
" let g:floaterm_keymap_new    = '<F7>'
" let g:floaterm_keymap_prev   = '<F8>'
" let g:floaterm_keymap_next   = '<F9>'
" let g:floaterm_keymap_toggle = '<F12>'
" let g:floaterm_rootmarkers   = ['.git']
" hi FloatermBorder guifg=orange
" " voldikss/vim-skylight
" hi SkylightBorder guibg=skyblue guifg=black
" " simnalamburt/vim-mundo
" let g:mundo_width              = 30
" let g:mundo_preview_height     = 10
" let g:mundo_right              = 0
" let g:mundo_preview_bottom     = 1
" let g:mundo_auto_preview_delay = 10
" " voldikss/vim-codelf
" let g:codelf_status = ''
" " voldikss/mark.vim
" nmap <silent> <Leader>k <Plug>MarkSet
" vmap <silent> <Leader>k <Plug>MarkSet
" nmap <silent> <Leader>K <Plug>MarkClear
" " tommcdo/vim-exchange
" nmap <silent> cx  <Plug>(Exchange)
" xmap <silent> X   <Plug>(Exchange)
" nmap <silent> cxc <Plug>(ExchangeClear)
" nmap <silent> cxx <Plug>(ExchangeLine)
" " tomtom/tcomment_vim
" let g:tcomment_types = {'c': '// %s', 'jsonc': '// %s'}
" nnoremap <silent> gC vil:TCommentInline<CR>
" vnoremap <silent> gC :TCommentBlock<CR>
" " matze/vim-move
" let g:move_map_keys    = 0
" let g:move_auto_indent = 1
" vmap <silent> J <Plug>MoveBlockDown
" vmap <silent> K <Plug>MoveBlockUp
" nmap <silent> J <Plug>MoveLineDown
" nmap <silent> K <Plug>MoveLineUp
" " andrewradev/sideways.vim
" nnoremap <silent> <C-left>  :SidewaysLeft<CR>
" nnoremap <silent> <C-right> :SidewaysRight<CR>
" omap <silent> as <Plug>SidewaysArgumentTextobjA
" xmap <silent> as <Plug>SidewaysArgumentTextobjA
" omap <silent> is <Plug>SidewaysArgumentTextobjI
" xmap <silent> is <Plug>SidewaysArgumentTextobjI
" " foosoft/vim-argwrap
" nmap <silent> <leader>aw <Plug>(ArgWrapToggle)
" " junegunn/vim-easy-align
" xmap <silent> ga <Plug>(EasyAlign)
" nmap <silent> ga <Plug>(EasyAlign)
" " puremourning/vimspector
" let g:vimspector_enable_mappings = 'HUMAN'
" " hop.nvim
" " remove mapping set by vim-signature
" call timer_start(100, {->execute("nunmap ']")})
" call timer_start(100, {->execute("nunmap '[")})
" nnoremap <silent><nowait> ' <Cmd>HopWord<CR>
" vnoremap <silent><nowait> ' <Cmd>HopWord<CR>
" " vim-snipe
" map <silent> f <Plug>(snipe-f)
" map <silent> F <Plug>(snipe-F)
" " brglng/vim-im-select
" let g:im_select_enable_focus_events = 0
" " vista.vim
" let g:vista_echo_cursor_strategy = 'floating_win'
" let g:vista_close_on_jump = 0
" " glacambre/firenvim
" if exists('g:started_by_firenvim')
"   set guifont=MonacoB2\ Nerd\ Font\ Mono:h15
"   set lines=18 columns=80 laststatus=0
"   set laststatus=0
" endif
" let g:firenvim_config = {
"   \ 'globalSettings': {
"     \ '<C-w>': 'default',
"     \ '<C-n>': 'default'
"   \ },
"   \ 'localSettings': {
"     \ '.*': {
"       \ 'cmdline': 'neovim',
"       \ 'content': 'text',
"       \ 'priority': 0,
"       \ 'selector': 'textarea',
"       \ 'takeover': 'always'
"     \ }
"   \ }
" \ }
" let fc = g:firenvim_config['localSettings']
" let fc['https?://zhihu.com/.*'] = { 'takeover': 'never', 'priority': 1 }
" " sakhnik/nvim-gdb
" let g:nvimgdb_disable_start_keymaps = 1
" let g:nvimgdb_config = {
"       \ 'key_until':      '<Nop>',
"       \ 'key_continue':   '<Nop>',
"       \ 'key_next':       '<Nop>',
"       \ 'key_step':       '<Nop>',
"       \ 'key_finish':     '<Nop>',
"       \ 'key_breakpoint': '<Nop>',
"       \ 'key_frameup':    '<Nop>',
"       \ 'key_framedown':  '<Nop>',
"       \ 'key_eval':       '<Nop>',
"       \ 'key_quit':       '<Nop>',
"       \ 'set_tkeymaps':   'function("GdbCallAsync", "keymaps.set_t")',
"       \ 'set_keymaps':    'function("GdbCallAsync", "keymaps.set")',
"       \ 'unset_keymaps':  'function("GdbCallAsync", "keymaps.unset")',
"       \ 'sign_current_line': '▶',
"       \ 'sign_breakpoint': [ '●', '●²', '●³', '●⁴', '●⁵', '●⁶', '●⁷', '●⁸', '●⁹', '●ⁿ' ],
"       \ 'sign_breakpoint_priority': 10,
"       \ 'codewin_command': 'new'
"       \ }
"
" " lua plugins
" if has('nvim')
" lua <<EOF
"
" -- nacro90/numb.nvim
" require('numb').setup()
"
" -- nvim-treesitter
" require('nvim-treesitter.configs').setup {
"     highlight = {
"         enable = true,
"         disable = { 'rust', 'markdown', 'json', 'yaml' },
"     },
"     indent = {
"         enable = false
"     },
"     incremental_selection = {
"         enable = true,
"         disable = { 'cpp', 'lua' },
"         keymaps = {
"           init_selection = 'gnn',
"           node_incremental = "grn",
"           scope_incremental = "grc",
"           node_decremental = "grm",
"         }
"     },
"     refactor = {
"       highlight_definitions = {
"         enable = false
"       },
"       highlight_current_scope = {
"         enable = false
"       },
"       smart_rename = {
"         enable = true,
"         keymaps = {
"           smart_rename = "grr"
"         }
"       },
"       navigation = {
"         enable = true,
"         keymaps = {
"           goto_definition = "gnd",
"           list_definitions = "gnD"
"         }
"       }
"     },
"     textobjects = {
"       enable = true,
"       disable = {},
"       keymaps = {
"           ["iL"] = {
"             -- you can define your own textobjects directly here
"             python = "(function_definition) @function",
"             cpp = "(function_definition) @function",
"             c = "(function_definition) @function",
"             java = "(method_declaration) @function"
"           },
"           -- or you use the queries from supported languages with textobjects.scm
"           ["af"] = "@function.outer",
"           ["if"] = "@function.inner",
"           ["aC"] = "@class.outer",
"           ["iC"] = "@class.inner",
"           ["ac"] = "@conditional.outer",
"           ["ic"] = "@conditional.inner",
"           ["ae"] = "@block.outer",
"           ["ie"] = "@block.inner",
"       }
"     },
"     ensure_installed = {
"       'bash',
"       'c',
"       'cpp',
"       'css',
"       'go',
"       'html',
"       'java',
"       'javascript',
"       'json',
"       'python',
"       'rust',
"       'toml',
"       'typescript'
"     }
" }
"
" -- sindrets/diffview.nvim
" local cb = require'diffview.config'.diffview_callback
" require'diffview'.setup {
"   diff_binaries = false,    -- Show diffs for binaries
"   file_panel = {
"     width = 35,
"     use_icons = true        -- Requires nvim-web-devicons
"   },
"   key_bindings = {
"     -- The `view` bindings are active in the diff buffers, only when the current
"     -- tabpage is a Diffview.
"     view = {
"       ["<tab>"]     = cb("select_next_entry"),  -- Open the diff for the next file 
"       ["<s-tab>"]   = cb("select_prev_entry"),  -- Open the diff for the previous file
"     },
"     file_panel = {
"       ["j"]         = cb("next_entry"),         -- Bring the cursor to the next file entry
"       ["<down>"]    = cb("next_entry"),
"       ["k"]         = cb("prev_entry"),         -- Bring the cursor to the previous file entry.
"       ["<up>"]      = cb("prev_entry"),
"       ["<cr>"]      = cb("select_entry"),       -- Open the diff for the selected entry.
"       ["o"]         = cb("select_entry"),
"       ["R"]         = cb("refresh_files"),      -- Update stats and entries in the file list.
"       ["<tab>"]     = cb("select_next_entry"),
"       ["<s-tab>"]   = cb("select_prev_entry"),
"       ["<leader>e"] = cb("focus_files"),
"       ["<leader>b"] = cb("toggle_files"),
"     }
"   }
" }
"
" EOF
" endif
" " }}}
