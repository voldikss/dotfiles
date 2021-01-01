" vim:et sw=2 ts=2 fdm=marker
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss

" Basic: {{{
" HostProg:
if has('win32') || has('win64') || has('win32unix')
  let g:python3_host_prog='C:\Program Files\Python38/python.exe'
else
  let g:python3_host_prog='/usr/bin/python3'
endif

" Encoding
set encoding=utf-8 fileencoding=utf-8 fileformats=unix,mac,dos
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1

" Appearance
set number relativenumber background=dark display=lastline,uhex nowrap wrapmargin=0
set showmode shortmess+=I cmdheight=1 cmdwinheight=10 showbreak= breakindent breakindentopt=
set showmatch matchtime=0 matchpairs+=<:>,《:》,（:）,【:】,“:”,‘:’
set noshowcmd noruler rulerformat= laststatus=2 statusline=%t\ %=\ %m%r%y%w\ %3l:%-2c
set title ruler titlelen=100 titleold= titlestring=%f noicon norightleft showtabline=2
set cursorline nocursorcolumn colorcolumn= concealcursor=nvc conceallevel=0
set list listchars=tab:\|\ ,extends:>,precedes:< synmaxcol=3000 ambiwidth=single
set nosplitbelow nosplitright nostartofline linespace=0 whichwrap=b,s scrolloff=5 sidescroll=0
set noequalalways nowinfixwidth nowinfixheight winminwidth=3 winheight=3 winminheight=3
set termguicolors cpoptions+=I guicursor= guioptions-=e nowarn noconfirm

" Editing
set iminsert=0 imsearch=0 nopaste pastetoggle= nogdefault comments& commentstring=#\ %s
set smartindent autoindent shiftround shiftwidth=4 expandtab tabstop=4 smarttab softtabstop=4
set foldclose=all foldcolumn=0 nofoldenable foldlevel=0 foldmarker& foldmethod=indent
set textwidth=0 backspace=2 nrformats=hex formatoptions=cmMj nojoinspaces selectmode=mouse
set hidden autoread autowrite noautowriteall nolinebreak mouse=a modeline whichwrap=b,s,<,>,[,]
set noautochdir write nowriteany writedelay=0 verbose=0 verbosefile= notildeop noinsertmode
set tags=./tags,tags,.tags,.vim/tags,.vim/.tags tagfunc=CocTagFunc

" Clipboard
" set clipboard=unnamed

" Data files
set history=10000 noswapfile
set nospell spellfile=$HOME/.config/nvim/spell/en.utf-8.add
set nobackup nowritebackup backupdir=$HOME/.cache/nvim/backup_dir
set undofile undolevels=1000 undodir=$HOME/.cache/nvim/undo_dir
set dictionary+=~/.config/nvim/dict/dictionary.txt

" Search
set wrapscan ignorecase smartcase incsearch hlsearch magic shortmess-=S
set path=.,/usr/local/include,/usr/include,**3 isfname-==

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

" Performance
set updatetime=100 timeout timeoutlen=500 ttimeout ttimeoutlen=50 ttyfast lazyredraw

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

colorscheme srcery
" }}}

" Plugin: {{{
call plug#begin('~/.cache/nvim/plugged')
" Languages
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'sakhnik/nvim-gdb', {'do': ':!./install.sh', 'on': 'GdbStart'} " use to debug nvim itself
Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}
Plug 'fatih/vim-go'
Plug 'iamcco/markdown-preview.nvim', {'for': 'markdown', 'do': 'cd app && npm install'}
Plug 'lervag/vimtex'
" Plug 'numirias/semshi', {'for': 'python'}
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'othree/html5.vim'
Plug 'posva/vim-vue', {'for': 'vue'}
Plug 'rust-lang/rust.vim', {'for': 'rust'}
Plug 'tpope/vim-dadbod', {'for': ['sql', 'mysql']}
" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Style
Plug 'Yggdroot/indentLine'
Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'guns/xterm-color-table.vim', {'on': 'XtermColorTable'}
Plug 'kshenoy/vim-signature'
Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'mhinz/vim-startify', {'on': 'Startify'}
Plug 'ryanoasis/vim-devicons'
" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
" Others
Plug 'brglng/vim-im-select', {'on': 'ImSelectEnable'}
" Plug 'puremourning/vimspector'
Plug 'easymotion/vim-easymotion'
Plug 'yangmillstheory/vim-snipe'
Plug 'Yggdroot/LeaderF', { 'do': './install.sh' }
Plug 'andrewradev/sideways.vim'
Plug 'foosoft/vim-argwrap', {'on': '<Plug>(ArgWrapToggle)'}
Plug 'junegunn/vader.vim'
Plug 'junegunn/vim-easy-align', {'on': '<Plug>(EasyAlign)'}
Plug 'junegunn/vim-peekaboo'
Plug 'liuchengxu/vista.vim'
Plug 'liuchengxu/vim-clap'
Plug 'vn-ki/coc-clap'
Plug 'matze/vim-move'
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'skywind3000/asyncrun.vim', {'on': ['AsyncRun', 'AsyncStop'] }
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/vim-dict'
Plug 'tommcdo/vim-exchange'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-browser-search'
Plug 'voldikss/vim-skylight'
Plug 'voldikss/vim-codelf'
Plug 'voldikss/vim-floaterm'
Plug 'voldikss/vim-fnote'
Plug 'voldikss/vim-hello-word'
Plug 'voldikss/vim-translator'
Plug 'wellle/targets.vim'
Plug 'yianwillis/vimcdoc'
call plug#end()
" }}}

" Autocmds: {{{
" autocmd CmdlineEnter * call feedkeys("\<C-p>")
augroup ParenColor
  autocmd!
  autocmd VimEnter,BufWinEnter *
    \ if index(['html', 'htmldjango', 'tex', 'mma', 'vue', 'xml'], &filetype) < 0 |
      \ syntax match paren1 /[{}]/   | hi paren1 guifg=#FF00FF |
      \ syntax match paren2 /[()]/   | hi paren2 guifg=#DF8700 |
      \ syntax match paren3 /[<>]/   | hi paren3 guifg=#0087FF |
      \ syntax match paren4 /[\[\]]/ | hi paren4 guifg=#00FF5F |
    \ endif
augroup END

augroup FileTypeAutocmds
  autocmd!
  autocmd FileType startify nmap <buffer> l <CR>
  autocmd FileType floaterm setlocal nocursorline
  autocmd FileType help setlocal number
  autocmd FileType * set formatoptions-=cro
augroup END

augroup AutoSaveBuffer
  autocmd!
  autocmd FocusLost,InsertLeave * call fn#file#autosave()
augroup END

augroup LineNumber
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu | set nornu | endif
augroup END

" augroup EqualWindowSize
"   autocmd!
"   autocmd VimResized * exec "normal \<C-w>="
" augroup END

augroup JumpToLastPosition
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype != 'gitcommit' |
      \ exe "normal! g'\"" |
    \ endif
augroup END

augroup KeywordHighlight
  autocmd!
  autocmd Syntax *
    \ call matchadd('Special', '\W\zs\(TODO\|FIXME\|CHANGED\|XXX\|BUG\|HACK\)\ze:') |
    \ call matchadd('Special', '\W\zs\(todo\|fixme\|xxx\|bug\)\ze:') |
    \ call matchadd('Special', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\|TMP\)\ze:') |
    \ call matchadd('Special', '\W\zs\(DEBUG\|Debug\)\ze:') |
    \ call matchadd('Special', '\W\zs\(@VOLDIKSS\|@voldikss\)\ze:')
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

augroup CocAutocmds
  autocmd!
  autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup END

augroup StartifyAutocmds
  autocmd!
  autocmd User Startified setlocal buflisted
augroup END

augroup CocExplorerCustom
  autocmd!
  autocmd FileType coc-explorer setlocal relativenumber
  autocmd BufEnter coc-explorer
    \ if &ft == 'coc-explorer'
    \ | call CocAction('runCommand', 'explorer.doAction', 'closest', ['refresh'])
    \ | endif
augroup END

if has('nvim')
augroup TerminalSettings
  autocmd!
  autocmd TermOpen * call timer_start(10, { -> fn#terminal#settings() }) |
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
  exe 'hi MyBookmarkSign        guifg=#0000FF guibg=' . signcolumn_bg

  hi VertSplit                  guifg=cyan
  " hi CocFloating                guibg=blue
  hi CursorLineNr               guifg=orange
  hi Normal                     guibg=#111111 guifg=#eeeeee
  hi PmenuThumb                  guifg=white guibg=white
  hi VisualNOS                  guibg=#404D3D

  let normal_bg = matchstr(execute('hi Normal'), 'guibg=\zs\S*')
  exe 'hi EndOfBuffer           guifg=' . normal_bg

  " coclist will(might) change my cursor highlight
  hi Cursor gui=reverse guifg=NONE guibg=NONE
endfunc
call s:OnColorSchemeLoaded()
augroup HlGroupSettings
  autocmd!
  autocmd ColorScheme * call s:OnColorSchemeLoaded()
augroup END
endif

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
call s:SetCommandAbbrs('ca', 'CocAction')
call s:SetCommandAbbrs('cc', 'CocConfig')
call s:SetCommandAbbrs('cf', 'CocFix')
call s:SetCommandAbbrs('ci', 'CocInstall')
call s:SetCommandAbbrs('cl', 'CocList')
call s:SetCommandAbbrs('cm', 'CocCommand')
call s:SetCommandAbbrs('cr', 'CocRestart')
call s:SetCommandAbbrs('cs', 'CocSearch')
call s:SetCommandAbbrs('cu', 'CocUninstall')
call s:SetCommandAbbrs('fk', 'FloatermKill')
call s:SetCommandAbbrs('fn', 'FloatermNew')
call s:SetCommandAbbrs('fs', 'FloatermSend')
call s:SetCommandAbbrs('fu', 'FloatermUpdate')
call s:SetCommandAbbrs('gap', 'Git add -p')
call s:SetCommandAbbrs('gc', 'Gcommit -v')
call s:SetCommandAbbrs('gca', 'Gcommit --amend -v')
call s:SetCommandAbbrs('gco', 'AsyncRun git checkout .')
call s:SetCommandAbbrs('gd', 'Gvdiff')
call s:SetCommandAbbrs('gl', 'Git lg')
call s:SetCommandAbbrs('gpull', 'AsyncRun git pull')
call s:SetCommandAbbrs('gpush', 'AsyncRun git push')
call s:SetCommandAbbrs('gs', 'Gstatus')
call s:SetCommandAbbrs('gw', 'Gw\|e')
call s:SetCommandAbbrs('gwa', 'Gwa\|e')
call s:SetCommandAbbrs('man', 'Man')
call s:SetCommandAbbrs('pc', 'PlugClean')
call s:SetCommandAbbrs('pi', 'PlugInstall')
call s:SetCommandAbbrs('pu', 'PlugUpdate')
call s:SetCommandAbbrs('sl', 'CocCommand session.load default')
call s:SetCommandAbbrs('ss', 'CocCommand session.save default')
call s:SetCommandAbbrs('st', 'Startify')
call s:SetCommandAbbrs('tm', 'TabMessage')
call s:SetCommandAbbrs('w!!', '%!sudo tee >/dev/null %')
" }}}

" Commands: {{{
command! AutoFormat call fn#file#autoformat()
command! OpenFileExplorer call fn#command#open_file_explorer()
command! CloseNoBuflistedBuffers call fn#buffer#close_nobuflisted_bufs()
command! CloseNoCurrentBuffers call fn#buffer#close_nocurrent_bufs()
command! CloseNoDisplayedBuffers call fn#buffer#close_nodisplayed_bufs()
command! Gwa AsyncRun -cwd=<root> -silent=1 git add .
command! Template call fn#template#TLoad()
command! QfToggle call fn#qf#toggle()
command! -nargs=* Zeal call fn#command#zeal(<q-args>)
command! -nargs=* SyntaxAt call fn#command#syntax_at(<f-args>)
command! -nargs=? Bline call fn#command#insert_line('bold', <f-args>)
command! -nargs=? Cline call fn#command#insert_line('comment', <f-args>)
command! -nargs=? Line call fn#command#insert_line('light', <f-args>)
command! -nargs=? RenameFile call fn#file#rename(<q-args>)
command! -nargs=? RemoveFile call fn#file#remove()
command! -nargs=+ Grep  call fn#command#grep(<q-args>)
command! -nargs=+ -complete=file  SystemOpen  call fn#lib#system_open(<q-args>)
command! -nargs=+ -complete=command Windo call fn#command#windo(<q-args>)
command! -nargs=+ -complete=command Bufdo call fn#command#bufdo(<q-args>)
command! -nargs=+ -complete=command Tabdo call fn#command#tabdo(<q-args>)
command! -nargs=+ -complete=command  TabMessage call fn#command#tab_message(<q-args>)
command! -nargs=? -complete=customlist,fn#quickrun#Complete QuickRun call fn#quickrun#run(<f-args>)
command! -nargs=? YarnWatch call floaterm#new(0, empty(<q-args>) ? 'yarn watch' : <q-args>, {
  \ 'on_stdout': function('fn#floaterm#watch_callback'),
  \ 'on_stderr': function('fn#floaterm#watch_callback'),
  \ 'on_exit': function('fn#floaterm#watch_callback')
  \ }, {})
" }}}

" Mappings: {{{
let mapleader   = ';'
let g:mapleader = ';'
noremap  H  ^
noremap  L  $
" Esc:
inoremap <C-c> <C-R>=fn#keymap#i#Esc()<CR>
inoremap <C-[> <C-R>=fn#keymap#i#Esc()<CR>
inoremap <Esc> <C-r>=fn#keymap#i#Esc()<CR>
"cannot use noremap
nmap     M  %
omap     M  %
xmap     M  %
noremap  U  <C-R>
noremap  '  `
vnoremap <  <gv
vnoremap >  >gv
nnoremap <C-u> <C-u>zz
nnoremap <C-d> <C-d>zz
nnoremap <silent> <C-g> :call fn#keymap#ctrlg#()<CR>
" PreviewAndOpen:
nnoremap <silent> gp  :<C-u>Skylight!<CR>
" Move:
nnoremap <silent> [[  :<C-u>call fn#keymap#n#right_square_brackets()<CR>
nnoremap <silent> ]]  :<C-u>call fn#keymap#n#left_square_brackets()<CR>
vnoremap <silent> [[  {j
vnoremap <silent> ]]  }k
" Jump:
nnoremap <silent> <C-j>      :<C-u>call fn#keymap#n#jump()<CR>
nnoremap <silent> <C-k>      :<C-u>call fn#coc#showdoc()<CR>
nnoremap <silent> <C-w><C-j> <C-W>v<C-]>zz
nnoremap <silent> <C-w><C-o> :<C-u>call fn#legacy#jumpback()<CR>
" Search:
nnoremap <expr> n  'Nn'[v:searchforward].'zz'
nnoremap <expr> N  'nN'[v:searchforward].'zz'
nnoremap * m`:keepjumps normal! *``zz<cr>
nnoremap # #zz
xnoremap * :<C-u>call fn#keymap#x#visual_star_search('/')<CR>/<C-R>=@/<CR><CR>N
xnoremap # :<C-u>call fn#keymap#x#visual_star_search('?')<CR>?<C-R>=@/<CR><CR>n
" TextObject:
" document
xnoremap <silent> id GoggV
onoremap <silent> id :normal vid<CR>
" line
xnoremap <silent> il g_o^
onoremap <silent> il :normal vil<CR>
" block comment
xnoremap i? [*o]*
onoremap i? :<C-u>normal va?V<CR>
" url
xnoremap <silent> iu :<C-u>call fn#textobj#url#()<CR>
onoremap <silent> iu :normal viu<CR>
" ip
xnoremap <silent> iI :<C-u>call fn#textobj#ip#()<CR>
onoremap <silent> iI :normal viI<CR>
" number
xnoremap <silent> in :<C-u>call fn#textobj#number#()<CR>
onoremap <silent> in :normal vin<CR>
" function argument
xnoremap <silent> ia :<C-u>call fn#textobj#argument#(1, 1)<CR>
xnoremap <silent> aa :<C-u>call fn#textobj#argument#(0, 1)<CR>
onoremap <silent> ia :<C-u>call fn#textobj#argument#(1, 0)<CR>
onoremap <silent> aa :<C-u>call fn#textobj#argument#(0, 0)<CR>
" BufferOperation:
nnoremap <expr> <silent> <C-h>  (&filetype == 'floaterm') ? ':FloatermPrev<CR>' : ':bprev<CR>'
nnoremap <expr> <silent> <C-l>  (&filetype == 'floaterm') ? ':FloatermNext<CR>' : ':bnext<CR>'
" tnoremap <expr> <silent> <C-h>  (&filetype == 'floaterm') ? '<C-\><C-n>:FloatermPrev<CR>' : '<C-\><C-n>:bprev<CR>'
" tnoremap <expr> <silent> <C-l>  (&filetype == 'floaterm') ? '<C-\><C-n>:FloatermNext<CR>' : '<C-\><C-n>:bnext<CR>'
" TabOperation:
noremap  <silent> <C-t> <Esc>:tabnew<CR>
" TextCopy:
nnoremap Y y$
nnoremap <silent> <Leader>y "+yy
vnoremap <silent> <Leader>y "+y
nnoremap <silent> <Leader>Y "+y$
nnoremap <silent> <Leader>p "+p
nnoremap <silent> <Leader>P "+P
nnoremap <silent> <M-d> :%s///g<CR>
vnoremap <silent> <M-d> :s///g<CR>
" InsertMode: move
inoremap <silent> <C-k> <Up>
inoremap <silent> <C-j> <Down>
" snoremap <silent> <C-j> <Down>
inoremap <silent> <C-h> <Left>
inoremap <silent> <C-l> <Right>
inoremap <silent> <C-b> <C-r>=fn#keymap#exec('normal! b')<CR>
inoremap <silent> <C-f> <C-r>=fn#keymap#exec('normal! w')<CR>
inoremap <silent> <C-a> <Home>
inoremap <silent> <C-e> <End>
inoremap <silent> <C-o> <End><CR>
inoremap <silent> <M-o> <Esc>O
inoremap <silent> <C-d> <Esc>ddi
inoremap <silent> <C-v> <C-o>"+]p

nnoremap <silent>       <Leader>w :w<CR>
nnoremap <silent>       <Leader>W :wa<CR>
nnoremap <silent>       <M-q> q
nnoremap <silent>       <Leader>Q Q
nnoremap <silent><expr> q len(getbufinfo({'buflisted':1})) < 2 ? ":q!\<CR>" : ":bd!\<CR>"
nnoremap <silent>       Q         :qa!<CR>
nnoremap <silent><expr> <Leader>d fn#keymap#n#q()
" nnoremap <silent> <Leader>Q :qa!<CR>
" noremap  <silent> <Leader>d :bp<bar>sp<bar>bn<bar>bd!<bar>:redraw!<CR>
" QuickMessage:
nnoremap <silent> <Leader>m :messages<CR>
nnoremap <silent> <Leader>t :TabMessage messages<CR>
" CommandMode:
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>
" cnoremap <expr> '    fn#keymap#c#pairs("''")
cnoremap <expr> <    fn#keymap#c#pairs('<>')
" cnoremap <expr> (    fn#keymap#c#pairs('()')
cnoremap <expr> [    fn#keymap#c#pairs('[]')
cnoremap <expr> {    fn#keymap#c#pairs('{}')
cnoremap <expr> <BS> fn#keymap#c#BS()
" TerminalMode:
if has('nvim')
  tnoremap <Esc>  <C-\><C-n>
endif
" tnoremap <expr> <C-R> '<C-\><C-N>"'.nr2char(getchar()).'pi'
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
  inoremap <silent> <M-]> <C-R>=fn#keymap#i#flyoutpairs(']')<CR>
  inoremap <silent> <M-}> <C-R>=fn#keymap#i#flyoutpairs('}')<CR>
  inoremap <silent> <M-)> <C-R>=fn#keymap#i#flyoutpairs(')')<CR>
endif
" WindowSize:
if has('nvim')
  nnoremap <M-up>    <C-w>+
  nnoremap <M-down>  <C-w>-
  nnoremap <M-left>  <C-w>10<
  nnoremap <M-right> <C-w>10>
  inoremap <M-up>    <Esc><C-w>+
  inoremap <M-down>  <Esc><C-w>-
  inoremap <M-left>  <Esc><C-w>10<
  inoremap <M-right> <Esc><C-w>10>
endif
" ClearnSearchHighlight:
if has('nvim')
  nnoremap <Esc>      <Cmd>nohlsearch<bar>echo<CR>
endif
nnoremap <silent> <BS>            :noh<bar>echo ''<CR>

noremap  <silent> <F2>             <Esc>:CocCommand explorer<CR>
noremap! <silent> <F2>             <Esc>:CocCommand explorer<CR>
tnoremap <silent> <F2>             <C-\><C-n>:CocCommand explorer<CR>
noremap  <silent> <F3>             <Esc>:MundoToggle<CR>
noremap! <silent> <F3>             <Esc>:MundoToggle<CR>
tnoremap <silent> <F3>             <C-\><C-n>:MundoToggle<CR>
noremap  <silent> <F4>             <Esc>:OpenFileExplorer<CR>
noremap  <silent> <F5>             <Esc>:QuickRun<CR>
noremap! <silent> <F5>             <Esc>:QuickRun<CR>
noremap  <silent> <Leader>x        <Esc>:QuickRun<CR>
noremap  <silent> <Leader><Space>  <Esc>:QfToggle<CR>
noremap  <silent> <F6>             <Esc>:AutoFormat<CR>
noremap  <silent> <Leader><Leader> <Esc>:AutoFormat<CR>
noremap! <silent> <F6>             <Esc>:AutoFormat<CR>
noremap  <silent> <F10>            <Esc>:Vista!!<CR>
noremap! <silent> <F10>            <Esc>:Vista!!<CR>
tnoremap <silent> <F10>            <C-\><C-n>:Vista!!<CR>
noremap  <silent> <F12>            <Esc>:FloatermToggle<CR>
noremap! <silent> <F12>            <Esc>:FloatermToggle<CR>
tnoremap <silent> <F12>            <C-\><C-n>:FloatermToggle<CR>
nnoremap <expr>   <CR>             fn#keymap#n#CR() . "\<Esc>"
inoremap <expr>   <CR>             fn#keymap#i#CR()
inoremap <expr>   <BS>             fn#keymap#i#BS()
" }}}

" Plugin Config: {{{
" octol/vim-cpp-enhanced-highlight
let g:cpp_class_scope_highlight                  = 1
let g:cpp_member_variable_highlight              = 1
let g:cpp_class_decl_highlight                   = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight                     = 1
" pangloss/vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow  = 1
" vim-python/python-syntax
let g:python_highlight_all = 1
let g:python_highlight_space_errors = 0
" lervag/vimtex
let g:tex_flavor='latex'
let g:vimtex_quickfix_mode = 0
let g:vimtex_view_method='general'
" let g:vimtex_view_method='zathura'
" @todo
" let g:vimtex_view_general_viewer = 'okular'
" let g:vimtex_view_general_options = '--unique file:@pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_mappings_enabled = 0
let g:vimtex_fold_enabled = 1
let g:vimtex_quickfix_open_on_warning = 0
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_compiler_latexmk_engines = {'_': '-xelatex'}
let g:vimtex_compiler_latexrun_engines = {'_': 'xelatex'}
" iamcco/markdown-preview.nvim
let g:mkdp_auto_close = 0
" numirias/semshi
let g:semshi#always_update_all_highlights = v:true
let g:semshi#error_sign = v:false
" neoclide/coc.nvim
let g:coc_data_home = '~/.config/coc'
nnoremap <silent><nowait><expr> <C-f>
        \ translator#window#float#has_scroll() ? translator#window#float#scroll(1) :
        \ skylight#float#has_scroll() ? skylight#float#scroll(1, 3) :
        \ coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <silent><nowait><expr> <C-b>
        \ translator#window#float#has_scroll() ? translator#window#float#scroll(0) :
        \ skylight#float#has_scroll() ? skylight#float#scroll(0, 3) :
        \ coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <silent><nowait><expr> <C-f>
        \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" :
        \ "<C-r>=fn#keymap#exec('normal! w')<CR>"
inoremap <silent><nowait><expr> <C-b>
        \ coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" :
        \ "<C-r>=fn#keymap#exec('normal! b')<CR>"
nmap <expr> <silent> <C-c> <SID>select_current_word_and_go_next()
function! s:select_current_word_and_go_next()
  if !get(g:, 'coc_cursors_activated', 0)
    return "\<Plug>(coc-cursors-word)"
  endif
  " based on coc readme, this has been modified
  " because I have mapped * to m`:keepjumps normal! *``zz<cr>
  return "*n\<Plug>(coc-cursors-word):nohlsearch\<CR>"
endfunc
nmap <silent> <M-n>      <Plug>(coc-diagnostic-next)
nmap <silent> <M-p>      <Plug>(coc-diagnostic-prev)
nmap <silent> <Leader>cl :<C-u>CocList<CR>
nmap <silent> <Leader>cs :<C-u>CocSearch <C-r><C-w><CR>
nmap <silent> <Leader>cf <Plug>(coc-fix-current)
nmap <silent> <Leader>cd <Plug>(coc-definition)
nmap <silent> <Leader>cr <Plug>(coc-refactor)
nmap <silent> <Leader>ci <Plug>(coc-implementation)
nmap <silent> <Leader>rn <Plug>(coc-rename)
nmap <silent> <Leader>rf <Plug>(coc-references-used)
nmap <silent> <Leader>rs :<C-u>CocRestart<CR>
xmap if <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-a)
omap ig <Plug>(coc-git-chunk-inner)
xmap ig <Plug>(coc-git-chunk-inner)
" coc-git
nmap <expr> <C-up>   &diff==1 ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <expr> <C-down> &diff==1 ? ']c' : '<Plug>(coc-git-nextchunk)'
nmap <expr> gk       &diff==1 ? '[c' : '<Plug>(coc-git-prevchunk)'
nmap <expr> gj       &diff==1 ? ']c' : '<Plug>(coc-git-nextchunk)'
nnoremap <silent> <Leader>hs :CocCommand git.chunkStage<CR>
nnoremap <silent> <Leader>hu :CocCommand git.chunkUndo<CR>
nnoremap <silent> <Leader>go :CocCommand git.browserOpen<CR>
nnoremap <silent> <Leader>gv :CocCommand git.chunkInfo<CR>
nnoremap <silent> <Leader>gm :CocCommand git.showCommit<CR>
nnoremap <silent> <Leader>gw :Gwrite \| e<CR>
nnoremap <silent> <Leader>gW :silent! Bufdo Gwrite<CR>
nnoremap <silent> <Leader>gc :Gcommit -v<CR>
nnoremap <silent> <Leader>ga :Gcommit --amend -v<CR>
nnoremap <silent> <Leader>gp :Gpush<CR>
" omap ic <Plug>(coc-text-object-inner)
" xmap ic <Plug>(coc-text-object-inner)
" coc-smartf
" nmap f <Plug>(coc-smartf-forward)
" nmap F <Plug>(coc-smartf-backward)
" autocmd User SmartfEnter :hi Conceal ctermfg=220 guifg=#6638F0
" autocmd User SmartfLeave :hi Conceal ctermfg=239 guifg=#504945
" coc-bookmark
nmap <silent> ,b <Plug>(coc-bookmark-toggle)
nmap <silent> ,a <Plug>(coc-bookmark-annotate)
nmap <silent> gh <Plug>(coc-bookmark-prev)
nmap <silent> gl <Plug>(coc-bookmark-next)
" coc-snippets
" 不要改动
inoremap <silent><expr> <TAB>
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
" coc extensions
let g:coc_global_extensions = [
  \ 'coc-bookmark',
  \ 'coc-browser',
  \ 'coc-clock',
  \ 'coc-cmake',
  \ 'coc-css',
  \ 'coc-diagnostic',
  \ 'coc-dictionary',
  \ 'coc-ecdict',
  \ 'coc-emmet',
  \ 'coc-emoji',
  \ 'coc-eslint',
  \ 'coc-explorer',
  \ 'coc-floaterm',
  \ 'coc-git',
  \ 'coc-highlight',
  \ 'coc-html',
  \ 'coc-java',
  \ 'coc-json',
  \ 'coc-leetcode',
  \ 'coc-lists',
  \ 'coc-marketplace',
  \ 'coc-pairs',
  \ 'coc-prettier',
  \ 'coc-pyright',
  \ 'coc-rust-analyzer',
  \ 'coc-syntax',
  \ 'coc-snippets',
  \ 'coc-tag',
  \ 'coc-tasks',
  \ 'coc-todolist',
  \ 'coc-translator',
  \ 'coc-tslint-plugin',
  \ 'coc-tsserver',
  \ 'coc-vimlsp',
  \ 'coc-vimtex',
  \ 'coc-word',
  \ 'coc-yank'
\ ]
" Yggdroot/indentLine
let g:indentLine_char = '│'
let g:indentLine_enabled = 1
let g:indentLine_color_term = 238
let g:indentLine_fileTypeExclude = ['startify', 'vista', 'json', 'codi', 'translator', 'jsonc', 'coc-explorer', 'man', 'help', 'floaterm']
" mhinz/vim-startify
let g:webdevicons_enable_startify = 1
noremap <silent> <Space><Space> <Esc>:Startify<CR>
function! s:stdpath_config() abort
  if has('nvim')
    return stdpath('config')
  else
    return has('unix') ? '~/.config/nvim' : 'C:\Users\voldikss\AppData\Local\nvim'
  endif
endfunction
let g:startify_bookmarks = [
  \ {'c': <SID>stdpath_config() . '/coc-settings.json'},
  \ {'v': <SID>stdpath_config() . '/init.vim'}
  \ ]
let g:startify_files_number = 8
let g:startify_padding_left = 15
" let g:startify_custom_header = [
"   \ '                      ___       ___       ___       ___       ___       ___       ___       ___   ',
"   \ '                     /\__\     /\  \     /\__\     /\  \     /\  \     /\__\     /\  \     /\  \  ',
"   \ '                    /:/ _/_   /::\  \   /:/  /    /::\  \   _\:\  \   /:/ _/_   /::\  \   /::\  \ ',
"   \ '                   |::L/\__\ /:/\:\__\ /:/__/    /:/\:\__\ /\/::\__\ /::-"\__\ /\:\:\__\ /\:\:\__\',
"   \ '                   |::::/  / \:\/:/  / \:\  \    \:\/:/  / \::/\/__/ \;:;-",-" \:\:\/__/ \:\:\/__/',
"   \ '                    L;;/__/   \::/  /   \:\__\    \::/  /   \:\__\    |:|  |    \::/  /   \::/  / ',
"   \ '                               \/__/     \/__/     \/__/     \/__/     \|__|     \/__/     \/__/  ']
if has('nvim')
  highlight StartifyHeader guifg=#FF00FF
  highlight StartifyNumber guifg=#00FF00
  highlight StartifyPath   guifg=#00AFFF
  highlight StartifySlash  guifg=#DF875F
endif
" itchyny/lightline.vim
let g:lightline = {
  \ 'colorscheme': 'aurora',
  \ 'active': {
    \ 'left': [
      \ ['mode', 'paste'],
      \ ['fugitive', 'readonly', 'filename'],
      \ ['absolutepath']
    \ ],
    \ 'right': [
      \ ['asyncrun_status'],
      \ ['lineinfo'],
      \ ['percent'],
      \ ['cocstatus', 'fileformat', 'fileencoding'],
      \ ['filetype'],
      \ ['codelf_status'],
      \ ['translator_status'],
    \ ]
  \ },
  \ 'inactive': {
    \ 'left': [
      \ ['mode', 'paste'],
      \ ['fugitive', 'readonly', 'filename'],
      \ ['absolutepath']
    \ ],
    \ 'right': [
      \ ['lineinfo'],
      \ ['percent'],
      \ ['fileformat', 'fileencoding'],
      \ ['filetype']
    \ ]
  \ },
  \ 'tabline': {
    \ 'left': [['vim_logo', 'buffers']],
    \ 'right': [['close']],
    \ 'subseparator': {
      \ 'left': '│',
      \ 'right': '│'
    \ }
  \ },
  \ 'component': {
    \ 'lineinfo': ' %l,%-v',
    \ 'percent': '%p%%',
    \ 'close': '%{has("nvim") ? " NVIM " : " VIM "}',
    \ 'vim_logo': "  "
  \ },
  \ 'component_function': {
    \ 'asyncrun_status': 'fn#lightline#AsyncRunStatus',
    \ 'codelf_status': 'fn#lightline#Codelf_Status',
    \ 'translator_status': 'fn#lightline#Translator_Status',
    \ 'mode': 'fn#lightline#Mode',
    \ 'fugitive': 'fn#lightline#GitBranch',
    \ 'cocstatus': 'coc#status',
    \ 'readonly': 'fn#lightline#ReadOnly',
    \ 'filename': 'fn#lightline#FileName',
    \ 'fileformat': 'fn#lightline#FileFormat',
    \ 'fileencoding': 'fn#lightline#FileEncoding',
    \ 'filetype': 'fn#lightline#FileType',
    \ 'absolutepath': 'fn#lightline#AbsPath'
  \ },
  \ 'component_expand': { 'buffers': 'lightline#bufferline#buffers' },
  \ 'component_type': { 'buffers': 'tabsel' },
  \ 'subseparator': {
    \ 'left': '│',
    \ 'right': '│'
  \ }
\ }
" mengelbrecht/lightline-bufferline
let g:lightline#bufferline#unnamed = '[No Name]'
let g:lightline#bufferline#filename_modifier = ':t'
let g:lightline#bufferline#enable_devicons = 1
let g:lightline#bufferline#unicode_symbols = 1
let g:lightline#bufferline#show_number  = 3
let g:lightline#bufferline#number_map = {
  \ 0: '⁰', 1: '¹', 2: '²', 3: '³', 4: '⁴',
  \ 5: '⁵', 6: '⁶', 7: '⁷', 8: '⁸', 9: '⁹'
\ }
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
" skywind3000/asyncrun.vim
let g:asyncrun_status = ''  " asyncrun is lazy loaded
let g:asyncrun_open = 9
let g:asyncrun_rootmarks = ['.git', '.root', '.tasks']
command! -bang -nargs=* -complete=file Make AsyncRun -cwd=<root> -program=make @ <args>
" skywind3000/asynctasks.vim
let g:asynctasks_term_pos = 'bottom'
let g:asynctasks_term_reuse = 0
let g:asynctasks_term_rows = 10
" Yggdroot/LeaderF
nmap <silent> <Leader>fb :Leaderf buffer<CR>
nmap <silent> <Leader>fc :Leaderf cmdHistory<CR>
nmap <silent> <Leader>ff :Leaderf file<CR>
nmap <silent> <Leader>fg :Leaderf rg<CR>
nmap <silent> <Leader>fl :Leaderf line<CR>
nmap <silent> <Leader>fm :Leaderf mru<CR>
nmap <silent> <Leader>ft :Leaderf bufTag<CR>
nmap <silent> <Leader>fu :Leaderf function<CR>
nmap <silent> <Leader>fr :Leaderf! --recall --stayOpen<CR>
" noremap <silent> <Leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <silent> <Leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
" noremap <silent> <Leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
" noremap <silent> <Leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>
let g:Lf_CacheDirectory       = expand('~/.cache/nvim')
let g:Lf_CommandMap = {
  \'<Up>': ['<C-p>'],
  \'<Down>': ['<C-n>'],
  \'<Home>': ['<C-A>'],
\}
let g:Lf_Ctags                = "/usr/local/bin/ctags"
let g:Lf_DefaultExternalTool = ""
let g:Lf_FilerShowDevIcons = 1
let g:Lf_GtagsAutoGenerate = 1
let g:Lf_Gtagslabel = 'native-pygments'
let g:Lf_HideHelp             = 1
let g:Lf_IndexTimeLimit       = 10
let g:Lf_MruFileExclude = ['*.so','*.py[c0]','*.exe','*.sw?']
let g:Lf_PreviewInPopup = 1
let g:Lf_PreviewResult        = {'Function':0, 'BufTag':0}
let g:Lf_RgConfig = [
  \"--glob=!OmegaOptions.bak",
  \"--glob=!node_modules",
  \"--glob=!lib/*.js",
  \"--glob=!target",
  \"--glob=!tags",
  \"--glob=!build",
  \"--glob=!.git",
  \"--glob=!.ccls-cache",
  \"--no-ignore",
  \"--hidden"
\]
let g:Lf_RootMarkers    = [
  \'.project',
  \'.svn',
  \'.git',
  \'.idea',
  \'.tasks',
  \'.clang-format',
\]
let g:Lf_ShowHidden           = 1
let g:Lf_ShowRelativePath     = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator   = {'left': '', 'right': '', 'font': ''}
let g:Lf_UseVersionControlTool = 0
let g:Lf_WildIgnore = {
  \'dir': [
    \'.svn',
    \'.git',
    \'.hg',
    \'.cache',
    \'.idea',
    \'.ccls-cache',
    \'.android',
    \'.gradle',
    \'.IntelliJIdea*',
    \'node_modules',
    \'build'
  \],
  \'file': [
    \'*.sw?',
    \'~$*',
    \'*.exe',
    \'*.o',
    \'*.so',
    \'*.py[co]'
  \]
\}
let g:Lf_WindowHeight = 0.4
let g:Lf_WorkingDirectoryMode = 'Ac'
" voldikss/vim-browser-search
nmap <silent> <Leader>s <Plug>SearchNormal
vmap <silent> <Leader>s <Plug>SearchVisual
let g:browser_search_engines = {
  \ 'qt': 'https://doc.qt.io/qt-5/search-results.html?q=%s'
  \ }
" voldikss/vim-translator
nmap <silent>    ,t        <Plug>Translate
nmap <silent>    ,w        <Plug>TranslateW
nmap <silent>    ,r        <Plug>TranslateR
vmap <silent>    ,t        <Plug>TranslateV
vmap <silent>    ,w        <Plug>TranslateWV
vmap <silent>    ,r        <Plug>TranslateRV
hi TranslatorBorder guifg=cyan
let g:translator_status = ''
let g:translator_history_enable = 1
let g:translator_default_engines = ['bing', 'google', 'haici', 'youdao']
let g:translator_window_max_height = 0.7
let g:translator_window_max_width = 0.7
" voldikss/vim-floaterm
let g:floaterm_title = 'floaterm ($1|$2)'
let g:floaterm_width = 0.6
let g:floaterm_height = 0.6
let g:floaterm_position = 'center'
let g:floaterm_gitcommit = 'split'
let g:floaterm_autoclose = 2
let g:floaterm_autohide = v:true
" let g:floaterm_autoinsert = v:false
let g:floaterm_keymap_new    = '<F7>'
let g:floaterm_keymap_prev   = '<F8>'
let g:floaterm_keymap_next   = '<F9>'
let g:floaterm_keymap_toggle = '<F12>'
" let g:floaterm_rootmarkers   = ['.git', '.gitignore', '*.pro', 'Cargo.toml']
" hi FloatermNC guibg=skyblue
hi FloatermBorder guifg=orange
command! PythonREPL  :FloatermNew --wintype=normal --width=0.5 --position=right python
" voldikss/vim-skylight
hi SkylightBorder guibg=skyblue guifg=black
" simnalamburt/vim-mundo
let g:mundo_width              = 30
let g:mundo_preview_height     = 10
let g:mundo_right              = 0
let g:mundo_preview_bottom     = 1
let g:mundo_auto_preview_delay = 10
" voldikss/vim-codelf
let g:codelf_status = ''
" lfv89/vim-interestingwords
nmap <silent> <Leader>k <Plug>MarkSet
vmap <silent> <Leader>k <Plug>MarkSet
nmap <silent> <Leader>K <Plug>MarkClear
" tommcdo/vim-exchange
nmap <silent> cx  <Plug>(Exchange)
xmap <silent> X   <Plug>(Exchange)
nmap <silent> cxc <Plug>(ExchangeClear)
nmap <silent> cxx <Plug>(ExchangeLine)
" tomtom/tcomment_vim
let g:tcomment_types = {'c': '// %s'}
" matze/vim-move
let g:move_map_keys    = 0
let g:move_auto_indent = 1
vmap <silent> J <Plug>MoveBlockDown
vmap <silent> K <Plug>MoveBlockUp
nmap <silent> J <Plug>MoveLineDown
nmap <silent> K <Plug>MoveLineUp
" andrewradev/sideways.vim
nnoremap <silent> <C-left>  :SidewaysLeft<CR>
nnoremap <silent> <C-right> :SidewaysRight<CR>
omap as <Plug>SidewaysArgumentTextobjA
xmap as <Plug>SidewaysArgumentTextobjA
omap is <Plug>SidewaysArgumentTextobjI
xmap is <Plug>SidewaysArgumentTextobjI
" foosoft/vim-argwrap
nmap <silent> <leader>aw <Plug>(ArgWrapToggle)
" junegunn/vim-easy-align
xmap <silent> ga <Plug>(EasyAlign)
nmap <silent> ga <Plug>(EasyAlign)
" puremourning/vimspector
let g:vimspector_enable_mappings = 'HUMAN'
" easymotion.vim
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map <silent> <Space>f <Plug>(easymotion-overwin-w)
map <silent> <Space>F <Plug>(easymotion-bd-f)
" vim-snipe
map <silent> f <Plug>(snipe-f)
map <silent> F <Plug>(snipe-F)
" brglng/vim-im-select
let g:im_select_enable_focus_events = 0
" vista.vim
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_close_on_jump = 0
" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
        disable = { 'rust', 'markdown', 'python' },
    },
    incremental_selection = {
        enable = true,
        disable = { 'cpp', 'lua' },
        keymaps = {
          init_selection = 'gnn',
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        }
    },
    refactor = {
      highlight_definitions = {
        enable = false
      },
      highlight_current_scope = {
        enable = false
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr"
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD"
        }
      }
    },
    textobjects = {
      enable = true,
      disable = {},
      keymaps = {
          ["iL"] = {
            -- you can define your own textobjects directly here
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function"
          },
          -- or you use the queries from supported languages with textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
      }
    },
    ensure_installed = {
      'bash',
      'c',
      'cpp',
      'css',
      'go',
      'html',
      'java',
      'javascript',
      'json',
      'python',
      'rust',
      'toml',
      'typescript'
    }
}
EOF
" }}}
