" @Author: VoldikSS
" @Date: 2019-01-04 16:32:15
" @Last Modified by: voldikss
" @Last Modified time: 2019-02-02 14:24:00

" ======================================================================
" Preface
" ======================================================================
" [[[
" Sections:
"    -> Basic Settings
"    -> Key Mappings
"    -> Customized Functions
"    -> Load Plugin
"    -> Plugin Settings
" Todo:
" ]]]

" ======================================================================
" Init
" ======================================================================
" [[[
let mapleader   = ';'
let g:mapleader = ';'
if has('win32') || has('win64') || has('win32unix') " If Windows OS
    if has('nvim')
        let g:python3_host_prog='D:/Applications/Python36/python.exe'
    else
        set pythonthreedll=/d/Applications/Python36/python36.dll
    endif
else  " Not Windows OS
    let g:python3_host_prog='/usr/bin/python3'
endif
" ]]]

" ======================================================================
" Load Plugins
" ======================================================================
" [[[
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

call plug#begin('~/.vim/plugged')
" [[[ Languages && Completion
" [[[ Languages
" Cpp
Plug 'octol/vim-cpp-enhanced-highlight'
" Go
Plug 'fatih/vim-go',{'for':'go'}
" Markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown',{'for':'markdown'}
Plug 'iamcco/mathjax-support-for-mkdp',{'for':'markdown'}
Plug 'iamcco/markdown-preview.nvim',{'for':'markdown'}
Plug 'dhruvasagar/vim-table-mode',{'for':'markdown'}
Plug 'xuhdev/SingleCompile'
" HTML
" Plug 'rstacruz/sparkup',{ 'for':'html' } " 在markdown中也会生效，占用 ctrl-e
Plug 'othree/html5.vim',{'for':'html'}
Plug 'mattn/emmet-vim',  {'for': ['html','vue','css']}
Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}
" JavaScript
if has('win32') || has('win64') || has('win32unix')
    Plug 'pangloss/vim-javascript',{'for':'javascript'}
    Plug 'ternjs/tern_for_vim',{'for':'javascript','do':'npm install'}
endif
" JSON
Plug 'elzr/vim-json',{'for':'json'}
" Wolfram
Plug 'VoldikSS/vim-mma',{'for':'mma'}
" ]]]

" [[[ Completion
if has('nvim')
    Plug 'Shougo/denite.nvim'
    Plug 'sirver/ultisnips'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    Plug 'Shougo/neco-vim'
    Plug 'neoclide/coc-neco'
else
    Plug 'vim-scripts/AutoComplPop'
endif
" ]]]
" ]]]

" [[[ ColorScheme && Format && Display && Interface
" ColorScheme
Plug 'chxuan/change-colorscheme'
" 彩虹括号
Plug 'luochen1990/rainbow'
" CSS 颜色高亮
Plug 'ap/vim-css-color'
" 格式化
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
" 界面
Plug 'justinmk/vim-dirvish'
Plug 'scrooloose/nerdtree',{'on': ['NERDTreeFind','NERDTreeToggle']}
Plug 'Xuyuanp/nerdtree-git-plugin',{'on':['NERDTreeFind','NERDTreeToggle']}
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'mhinz/vim-startify'
" 沉浸模式
Plug 'junegunn/goyo.vim'
" Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 图标
Plug 'ryanoasis/vim-devicons'
" undotree 可视化
Plug 'mbbill/undotree'
" mark 可视化
Plug 'kshenoy/vim-signature'
" bookmarks
Plug 'mattesgroeger/vim-bookmarks'

Plug 'osyo-manga/vim-over'
" ]]]

" [[[ Integrations && Enhancements
" [[[ Git
" Git operators
Plug 'tpope/vim-fugitive'
" GitHub(fugitive Gbrose support)
Plug 'tpope/vim-rhubarb'
" Git commit
Plug 'junegunn/gv.vim'
" Git diff
Plug 'mhinz/vim-signify'
" Gist
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
" Quick comment
Plug 'tpope/vim-commentary'
" ]]]

" [[[ Enhancements
" Syntax
" Plug 'w0rp/ale'
" 异步运行
Plug 'skywind3000/asyncrun.vim'
" sudo
Plug 'chrisbra/sudoedit.vim'
" ctag
Plug 'ludovicchabant/vim-gutentags'
" fuzzy finder
Plug 'Yggdroot/LeaderF'
" Lightweight web search
Plug 'voldikss/vim-search-me'
" Translator
Plug 'iamcco/dict.vim'
" Fileheader
Plug 'ahonn/fileheader.nvim'
" 空白符提示
Plug 'ntpeters/vim-better-whitespace'
" Mark + 高亮
Plug 'inkarkat/vim-mark'
Plug 'inkarkat/vim-ingo-library'
" LeetCode
Plug 'iandingx/leetcode.vim'
" ]]]

" [[[ Move
" 增强跳转
Plug 'easymotion/vim-easymotion'
" 增强在匹配符之间的跳转，比 matchit 更强大
Plug 'andymass/vim-matchup'
" 交换单词等
Plug 'tommcdo/vim-exchange'
" 移动整行/块
Plug 'matze/vim-move'
" 左右移动函数参数、列表元素等
Plug 'andrewradev/sideways.vim'
" ]]]

" [[[ Edit
" 增强替换功能，:S
Plug 'tpope/vim-abolish'
" 增强按键，扩展
Plug 'tpope/vim-unimpaired'
" 增强搜索，快速搜索光标下的词
Plug 'bronson/vim-visual-star-search'
" 成对符号编辑
Plug 'tpope/vim-surround'
" 让点范式(.)支持插件中的键映射，特别是对 vim-surround
Plug 'tpope/vim-repeat'
" 包装和解包列表、字典等
Plug 'foosoft/vim-argwrap'
" 自动闭合括号
Plug 'jiangmiao/auto-pairs'

" 对齐
Plug 'junegunn/vim-easy-align'
" 文本对象 Text objects
Plug 'kana/vim-textobj-user'
Plug 'kana/vim-textobj-entire'
Plug 'kana/vim-textobj-line'
Plug 'kana/vim-textobj-lastpat'
Plug 'kana/vim-textobj-fold'
Plug 'glts/vim-textobj-comment'
Plug 'jceb/vim-textobj-uri'
Plug 'reedes/vim-textobj-sentence'
Plug 'michaeljsmith/vim-indent-object'
Plug 'jeetsukumaran/vim-pythonsense'
Plug 'wellle/targets.vim'
Plug 'mg979/vim-visual-multi'
" ]]]
" ]]]

" [[[ Misc
" 中文帮助文档
Plug 'yianwillis/vimcdoc'
" Plug 'skywind3000/vim-keysound'
" ]]]

call plug#end()
" ]]]

" ======================================================================
" Basic Settings
" ======================================================================
" [[[
" Generic [[[
set history=2000

" 兼容 Dirvish 而关闭，由后面函数实现
set noautochdir
set modifiable

set autoread
set autowrite
set updatetime=5000
set nospell

set nobackup
set noswapfile
set nowritebackup
set undodir=~/.vim/.cache/undo_dir/
set undofile

" 映射超时和键码超时
set timeout
set ttimeout
set timeoutlen=500
set ttimeoutlen=20

set mouse=a
set mousehide
set selectmode=mouse
" 不适用系统剪切板，由 <Leader> 组合键实现
set clipboard=

set backspace=2
set backspace=eol,start,indent

set whichwrap=b,s,h,l,<,>,[,]
" ]]]

" Display [[[
colorscheme gruvbox

set termguicolors

set background=dark
set t_Co=256

set title
set ruler
set showcmd
set cursorline
set laststatus=2
set shortmess+=c

set scrolloff=6
set wrap
" 不设置自动折行
set textwidth=1000
" 设置提示线
" set colorcolumn=100

set showmatch
set matchtime=1
set matchpairs+=<:>
set matchpairs+=《:》
set matchpairs+=（:）
set matchpairs+=【:】
set matchpairs+=“:”
set matchpairs+=‘:’

set hlsearch
set incsearch
set wrapscan
set ignorecase
set smartcase

set foldlevel=99
set conceallevel=0

set autoindent
set smartindent

" tab -> space
set tabstop=4
set shiftwidth=4
set softtabstop=4
set smarttab
set expandtab
set shiftround

set relativenumber number

set lazyredraw
" ]]]

" Files [[[
set isfname-==
" 设置新文件的编码为 UTF-8
set encoding=utf-8
" 自动判断编码时，依次尝试以下编码：
set fileencodings=utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" 使用Unix文件格式
set fileformats=unix,dos,mac
" 如遇Unicode值大于255的文本，不必等到空格再折行
set formatoptions+=m
" 使用十进制
set nrformats=
" 自动保存文件改动跳转其他文件
set hidden
" 命令行文件名忽略大小写
set fileignorecase
" ]]]

" Others [[[
set completeopt=noinsert,longest

" 命令行使用tab时显示单行补全菜单
set wildmenu
set wildmode=longest,full
" 命令行补全文件名/目录等忽略大小写
set wildignorecase
set wildignore+=.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
set wildignore+=__pycache__,*.egg-info
" ctags, I use gutentags
" set tags=./.tags;,.tags
" 字典补全
" set dictionary+=~/.vim/dict/words.txt
set dictionary+=~/.vim/dict/user_defined_words.txt
" ]]]
" ]]]

" ======================================================================
" Key Mappings
" ======================================================================
" [[[
" 禁用 "Entering ex mode"
nnoremap Q <Nop>
" 禁用 <CR> 向下一行的功能，主要是为了使 <Leader>w<CR> 快速保存时防止光标跳到下一行
" https://vi.stackexchange.com/questions/3127/how-to-map-enter-to-custom-command-except-in-quick-fix
noremap <silent> <expr> <CR> &buftype ==# 'quickfix' ? "\<CR>" : '\<Nop>'

" 行首和行末快捷键
noremap H ^
noremap L $
" jj 替换 Esc
inoremap jj <Esc>
" U 为 redo
noremap U <C-r>
" 跳转标记更方便
noremap ' `

" C-j 跳转函数定义: Go to definition
noremap <Leader>g <C-]>
" C-k 跳转帮助: Help
noremap <Leader>h K

" 平滑滚屏
noremap <C-U> <C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y><C-Y>
noremap <C-D> <C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E><C-E>
" 查找时将结果置于屏幕中央
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" 编辑 vimrc
noremap <Leader>ve :edit   ~/.vimrc<CR>
" source vimrc
noremap <Leader>vs :source ~/.vimrc<CR>

" 搜索使用模式匹配
" 还是使用 magic 模式
" noremap / /\v

" 切换 buffer
noremap <silent> gj      :bnext<CR>
noremap <silent> gk      :bprev<CR>
noremap <silent> <S-Tab> :bnext<CR>
noremap <Leader>1 :1b<CR>
noremap <Leader>2 :2b<CR>
noremap <Leader>3 :3b<CR>
noremap <Leader>4 :4b<CR>
noremap <Leader>5 :5b<CR>
noremap <Leader>6 :6b<CR>
noremap <Leader>7 :7b<CR>
noremap <Leader>8 :8b<CR>
noremap <Leader>9 :9b<CR>
" 删除当前 buffer
noremap <silent> <Leader>d :bd!<CR>

" 切换窗口
noremap <C-h> <Esc><C-w>h
noremap <C-j> <Esc><C-w>j
noremap <C-k> <Esc><C-w>k
noremap <C-l> <Esc><C-w>l
" 调整窗口大小
noremap <M-k> <C-w>+
noremap <M-j> <C-w>-
noremap <M-h> <C-w>10<
noremap <M-l> <C-w>10>

" 新建 tab  Ctrl+T
noremap  <C-t>     <Esc>:tabnew<CR>
noremap! <C-t>     <Esc>:tabnew<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv
" nnoremap < V<
" nnoremap > V>

" 将选中文本块复制至系统剪贴板
nnoremap <Leader>y "+yy
vnoremap <Leader>y "+y
nnoremap <Leader>Y "+y$
" 设置快捷键将系统剪贴板内容粘贴至 vim
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
" 复制当前到行尾
nnoremap Y y$

" 选中
noremap <silent> <Leader>sa <Esc>ggVG
" 拷贝
vnoremap <silent> <C-c> "+y
" 保存
nnoremap <silent> <C-s> :update<CR>
inoremap <silent> <C-s> <ESC>:update<CR>
vnoremap <silent> <C-s> <ESC>:update<CR>
" 插入模式下的左右移动
inoremap <C-k> <Esc>ka
inoremap <C-j> <Esc>ja
inoremap <C-h> <Esc>ha
inoremap <C-l> <Esc>la
" 词首词尾: forward; bachward
inoremap <C-b> <Esc>bi
inoremap <C-f> <Esc>ea
" 行首行尾:
inoremap <C-a> <Home>
inoremap <C-e> <End>
" 新开一行
inoremap <C-o> <Esc>o
" 往下插入空行
inoremap <M-o> <Esc>O
" 删除整行
inoremap <C-d> <Esc>ddi
" 清除整行
inoremap <C-u> <Esc>cc
" 删除当前到行尾
inoremap <C-c> <Esc>C

" 快速退出
nnoremap <Leader>q  <Esc>:q<CR>
" 快速退不做任何保存
nnoremap <Leader>Q  <Esc>:qa!<CR>
" 快速保存
noremap <Leader>w  <Esc>:w<CR>
" 快速 grep TODO:异步
" noremap <Leader>gg :silent execute "AsyncRun grep -R " . shellescape(expand("<cWORD>")) . " ."<CR>:copen<CR>
noremap <Leader>gg :silent execute "grep -R " . shellescape(expand("<cWORD>")) . " ."<CR>:copen<CR>

" 命令行模式增强
" Ctrl-a 到行首，-e 到行尾
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
" 回溯历史命令时用 C-p 和 C-n 达到像 Up Down 一样的过滤效果
cnoremap <C-p> <Up>
cnoremap <C-n> <Down>
" 前进后退一个单词
cnoremap <C-b> <S-Left>
cnoremap <C-f> <S-Right>
" W 以 sudo 权限写入
cnoremap ww! w !sudo tee >/dev/null %

" 终端模式
tnoremap <Esc>  <C-\><C-n>
" 终端打开
noremap <silent> <Leader>n <Esc>:vert term<CR>
noremap <silent> ,n <Esc>:term<CR>

" 安装、更新、删除插件
nnoremap <Leader><Leader>i :PlugInstall<CR>
nnoremap <Leader><Leader>u :PlugUpdate<CR>
nnoremap <Leader><Leader>c :PlugClean<CR>
command! PU PlugUpdate | PlugUpgrade
command! PS PlugStatus
command! PC PlugClean
" ]]]

" ======================================================================
" Custom Functions
" ======================================================================
" [[[

" vimrc 采用 marker 折叠方式
augroup foldmethod_settings
    autocmd!
    autocmd BufNewFile,BufRead *.vimrc setlocal foldmarker=[[[,]]]
    autocmd BufNewFile,BufRead *.vimrc setlocal foldmethod=marker
    autocmd BufNewFile,BufRead *.vimrc setlocal foldtext='+'.substitute(getline(v:foldstart),'[\[\"]','','g').v:folddashes
augroup END

" 不同文件不同颜色主题
" 会导致 airline bug
" augroup colorscheme_change
"     autocmd!
"     autocmd BufEnter * if &filetype=='vim'      | colorscheme molokai | endif
"     autocmd BufEnter * if &filetype=='mma'      | colorscheme molokai | endif
"     autocmd BufEnter * if &filetype=='python'   | colorscheme gruvbox | endif
"     autocmd BufEnter * if &filetype=='startify' | colorscheme gruvbox | endif
"     autocmd BufEnter * if &filetype=='markdown' | colorscheme gruvbox | endif
" augroup END

" 保存 vimrc 时自动 source
augroup source_vimrc
    autocmd!
    autocmd BufWritePost ~/.vimrc nested source $MYVIMRC
augroup END

augroup no_comment
    autocmd!
    " 合并两行中文时，不在中间加空格
    set formatoptions+=B
    " 禁止自动加注释符号
    set formatoptions-=r
    set formatoptions-=c
    set formatoptions-=o
augroup END

" 清除搜索高亮
augroup clear_hl
    autocmd!
    autocmd InsertEnter * :let @/=""
augroup END

" 不同模式行号显示
augroup line_number
    autocmd!
    autocmd InsertEnter * :set norelativenumber number
    autocmd InsertLeave * :set relativenumber
augroup END

" 终端窗口大小变化时保持所有窗口同等大小
augroup equal_window_size
    autocmd!
    autocmd VimResized * exec "normal \<c-w>="
augroup END

augroup last_pos
    " 打开自动定位到最后编辑的位置, 需要确认 .viminfo 当前用户可写
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END

" 自动进入当前文件的目录，更好滴使用 NERDTree
augroup auto_ch_dir
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
augroup END

" 关键词高亮
" augroup syntax_highlight
"     autocmd!
"     autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|Todo\|todo\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
"     autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
" augroup END

" 个人 gitignore 默认配置
autocmd BufNewFile *.gitignore exec "call InitGitignore()"
function! InitGitignore()
    let s:ignore = ['################################################################',
                \ ' Generated by Vim function: InitGitignore',
                \ '.tags', '.idea/', '/.idea', '__pycache__', '*.pyc', '*.o', '*.out',
                \ 'build/',
                \ '################################################################']
    let s:lines = line('$')
    normal O
    call append(0, s:ignore)
endfunction

" 一键运行
noremap  <silent> <F5> <Esc>:call QuickRun()<CR>
noremap! <silent> <F5> <Esc>:call QuickRun()<CR>
function! QuickRun()
    exec 'w'
    if &filetype == 'c'
        exec "AsyncRun gcc % -o %<; ./%<"
        " 执行后聚焦 Quickfix 窗口
        " exec "AsyncRun gcc % -o %<; ./%<" | wincmd p
    elseif &filetype == 'cpp'
        exec "AsyncRun g++ % -o %<; ./%<"
    elseif &filetype == 'java'
        exec "AsyncRun javac %; java %<"
    elseif &filetype == 'sh'
        exec "AsyncRun bash %"
    elseif &filetype == 'lua'
        exec "AsyncRun lua %"
    elseif &filetype == 'python'
        exec "AsyncRun python3 %"
    elseif &filetype == 'html' || &filetype == 'htmldjango'
        exec "BrowserOpen " . expand("%:p")
    elseif &filetype == 'go'
        exec "AsyncRun go run %"
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    endif
endfunction
command! -nargs=+ BrowserOpen call BrowserOpen(<q-args>)
function! BrowserOpen(obj)
    " windows(mingw)
    if has('win32') || has('win64') || has('win32unix')
        let cmd = 'start rundll32 url.dll,FileProtocolHandler ' . a:obj
    elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
        let cmd = 'open' . a:obj
    elseif executable('xdg-open')
        let cmd = 'xdg-open ' . a:obj
    else
        echoerr "No browser path found, please contact the developer."
    endif

    if exists('*jobstart')
        call jobstart(cmd)
    elseif exists('*job_start')
        call job_start(cmd)
    else
        call system(cmd)
    endif
endfunction

" 捕获 Ex 命令的输出
command! -nargs=+ -complete=command TabMessage call TabMessage(<q-args>)
function! TabMessage(cmd)
  redir => message
  silent execute a:cmd
  redir END
  if empty(message)
    echoerr "no output"
  else
    new
    setlocal buftype=nofile bufhidden=wipe noswapfile nobuflisted nomodified
    silent put=message
  endif
endfunction
" ]]]

" ======================================================================
" Plugin Settings
" ======================================================================
" [[[
" airline
" [[[
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_powerline_fonts = 1
let g:airline_theme = 'aurora'
" let g:airline_theme = 'base16_spacemacs'
" let g:airline_theme = 'cool'
" let g:airline_theme = 'light'
" let g:airline_theme = 'vice'
"
" buffer 编号显示
let g:airline#extensions#tabline#buffer_nr_show = 1
" tab 编号显示
" let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensioin#tabline#right_sep = ''
let g:airline#extensioin#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#formatter = 'unique_tail'
" ]]]

" AsyncRun
" [[[
" 自动打开 quickfix window ，高度为 10
let g:asyncrun_open = 8
" 任务结束时候响铃提醒
let g:asyncrun_bell = 1
" 设置 F12 打开/关闭 Quickfix 窗口
nnoremap <Leader><Space> :call asyncrun#quickfix_toggle(8)<CR>
" ]]]

" auto-pairs
" [[[
let g:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '<':'>','（':'）','《':'》','‘':'’','“':'”'}
autocmd FileType python let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '（':'）','《':'》','‘':'’','“':'”'}
autocmd FileType markdown let b:AutoPairs ={'(':')', '[':']', '{':'}',"'":"'",'"':'"', '`':'`', '<':'>','（':'）','《':'》','‘':'’','“':'”','*':'*','~':'~'}
" 防止 C-h 被映射为 <BS>
let g:AutoPairsMapCh = 0
let g:AutoPairsMapSpace = 0
" Alt-e 快速加括号
let g:AutoPairsShortcutFastWrap = '<M-e>'
" Alt-p 开关插件
let g:AutoPairsShortcutToggle = '<M-p>'
" 解除一系列映射键
let g:AutoPairsShortcutJump = 'Disable'
let g:AutoPairsShortcutBackInsert = 'Disable'
let g:AutoPairsMapCR = 'Disable'
" ]]]

" change-colorscheme
" [[[
noremap  <silent> <F10> <Esc>:NextColorScheme<CR>
noremap! <silent> <F10> <Esc>:NextColorScheme<CR>
noremap  <silent> <F9>  <Esc>:PreviousColorScheme<CR>
noremap! <silent> <F9>  <Esc>:PreviousColorScheme<CR>
" ]]]

" coc
" [[[
" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Use <enter> to confirm complete
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<cr>"
" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
" ]]]

" dict.vim
" [[[
" --普通模式下，<Leader>d 即可翻译光标下的文本，并在命令行回显
nmap <silent> <Leader>tt <Plug>DictSearch
" --可视化模式下，<Leader>d 即可翻译选中的文本，并在命令行回显
vmap <silent> <Leader>tt <Plug>DictVSearch
" --普通模式下，<Leader>w 即可翻译光标下的文本，并且在Dict新窗口显示
nmap <silent> <Leader>tw <Plug>DictWSearch
" --可视化模式下，<Leader>w 即可翻译选中的文本，并且在Dict新窗口显示
vmap <silent> <Leader>tw <Plug>DictWVSearch
" --普通模式下，<Leader><Leader>r 即可翻译光标下的单词，并替换为翻译的结果
nmap <silent> <Leader><Leader>r <Plug>DictRSearch
" --可视化模式下，<Leader><Leader>r 即可翻译光标下的单词，并替换为翻译的结果
vmap <silent> <Leader><Leader>r <Plug>DictRVSearch
" ]]]

" fileheader
" [[[
let g:fileheader_auto_add = 0
let g:fileheader_auto_update = 0
let g:fileheader_author='voldikss'
let g:fileheader_default_email = 'dyzplus@gmail'
let g:fileheader_show_email = 0
let g:fileheader_by_git_config = 1
let g:fileheader_new_line_at_end = 1
let g:fileheader_last_modified_by = 1
let g:fileheader_last_modified_time = 1
" ]]]

" goyo.vim
" [[[
noremap <Leader>gy :Goyo<CR>
let g:goyo_width = '85'
let g:goyo_height = '85%'
let g:goyo_linenr = 1
" ]]]

" gv.vim
" [[[
noremap <Leader>gv :GV<CR>
" ]]]

" indentLine
" [[[
let g:indentLine_enabled = 1
let g:indentLine_color_term = 238
" ]]]

" LeaderF
" [[[
noremap <Leader>ff <Esc>:LeaderfFile<CR>
noremap <Leader>ft <Esc>:LeaderfBufTagAll<CR>
noremap <Leader>fb <Esc>:LeaderfBufferAll<CR>

let g:Lf_StlSeparator = {'left': '', 'right': '', 'font': ''}
let g:Lf_RootMarkers = ['.project', '.root', '.svn', '.git']
let g:Lf_MruFileExclude = ['*.so','*.py[c0]','*.exe','*.sw?']
let g:Lf_WildIgnore = {
            \ 'dir': ['.svn','.git','.hg','.cache','.idea','.android','.gradle','.IntelliJIdea*'],
            \ 'file': ['*.sw?','~$*','*.exe','*.o','*.so','*.py[co]']
            \}
let g:Lf_WorkingDirectoryMode = 'Ac'
let g:Lf_WindowHeight = 0.30
let g:Lf_CacheDirectory = expand('~/.vim/.cache')
let g:Lf_ShowRelativePath = 1
let g:Lf_HideHelp = 1
let g:Lf_ShowHidden = 1
let g:Lf_PreviewResult = {'Function':0, 'BufTag':0}
let g:Lf_IndexTimeLimit = 10
let g:Lf_Ctags = "/usr/local/bin/ctags"
" let g:Lf_PreviewCode = 1
let g:Lf_StlColorscheme = 'powerline'
let g:Lf_StlSeparator = {'left': '', 'right': '', 'font': ''}
" ]]]

" LeetCode.vim
" [[[
let g:leetcode_solution_filetype = 'python'
" ]]]

" markdown-preview
" [[[
let g:mkdp_auto_close = 0
"" ]]]

" NERDTree
" [[[
" 显示行号
let NERDTreeShowLineNumbers = 1
let NERDTreeAutoCenter = 1
" 是否显示隐藏文件
let NERDTreeShowHidden = 0
" 设置宽度
let NERDTreeWinSize = 28
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup = 1
" 忽略以下文件的显示
let NERDTreeIgnore = [
            \ '\.git$', '\.hg$', '\.svn$', '\.stversions$', '\.pyc$', '\.svn$','\~$',
	        \ '\.DS_Store$', '\.sass-cache$', '__pycache__$', '\.egg-info$', '\.cache$'
	        \ ]
" 显示书签列表
let NERDTreeShowBookmarks = 1
" 文件前面的标志符号"
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
" 打开目录时自动打开 NERDTree
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" 如果只剩下NERDTree则关闭vim
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
" 切换 NERDTree
noremap  <silent> <F2> <Esc>:call NERDTreeToggler()<CR>
noremap! <silent> <F2> <Esc>:call NERDTreeToggler()<CR>
function! NERDTreeToggler()
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
    exe ":NERDTreeClose"
  else
    if (expand("%:t") != '')
      exe ":NERDTreeFind"
    else
      exe ":NERDTreeToggle"
    endif
  endif
endfunction
" ]]]

" nerdtree-git-plugin
" [[[
let g:NERDTreeIndicatorMapCustom = {
            \ "Modified"  : "✹",
            \ "Staged"    : "✚",
            \ "Untracked" : "✭",
            \ "Renamed"   : "➜",
            \ "Unmerged"  : "═",
            \ "Deleted"   : "✖",
            \ "Dirty"     : "✗",
            \ "Clean"     : "✔︎",
            \ 'Ignored'   : '☒',
            \ "Unknown"   : "?"
            \ }
" ]]]

" rainbow
" [[[
let g:rainbow_active = 1
let g:rainbow_conf = {
            \   'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick'],
            \   'ctermfgs': ['lightblue', 'lightyellow', 'lightcyan', 'lightmagenta'],
            \   'operators': '_,_',
            \   'parentheses': ['start=/(/ end=/)/ fold', 'start=/\[/ end=/\]/ fold', 'start=/{/ end=/}/ fold'],
            \   'separately': {
            \       '*': {},
            \       'tex': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/'],
            \       },
            \       'lisp': {
            \           'guifgs': ['royalblue3', 'darkorange3', 'seagreen3', 'firebrick', 'darkorchid3'],
            \       },
            \       'vim': {
            \           'parentheses': ['start=/(/ end=/)/', 'start=/\[/ end=/\]/', 'start=/{/ end=/}/ fold', 'start=/(/ end=/)/ containedin=vimFuncBody', 'start=/\[/ end=/\]/ containedin=vimFuncBody', 'start=/{/ end=/}/ fold containedin=vimFuncBody'],
            \       },
            \       'html': {
            \           'parentheses': ['start=/\v\<((area|base|br|col|embed|hr|img|input|keygen|link|menuitem|meta|param|source|track|wbr)[ >])@!\z([-_:a-zA-Z0-9]+)(\s+[-_:a-zA-Z0-9]+(\=("[^"]*"|'."'".'[^'."'".']*'."'".'|[^ '."'".'"><=`]*))?)*\>/ end=#</\z1># fold'],
            \       },
            \       'css': 0,
            \   }
            \}
" ]]]

" sideways.vim
" [[[
nnoremap <C-left>  :SidewaysLeft<CR>
nnoremap <C-right>  :SidewaysRight<CR>
" ]]]

" vim-argwrap
" [[[
noremap <silent> <Leader>aw <Esc>:ArgWrap<CR>
autocmd FileType vim let b:argwrap_line_prefix = '\'
autocmd FileType vim let b:argwrap_tail_indent_braces = '('
" ]]]

" vim-autoformat
" [[[
" 保存文件时 FORMAT
let g:autoformat_enabled = 0
" noremap <C-p> <Esc>:call ToggleAutoformat()<CR>
autocmd BufWrite * if g:autoformat_enabled | exec "Autoformat" | endif
function! ToggleAutoformat()
    if g:autoformat_enabled
        let g:autoformat_enabled = 0
        echo "Autoformat disabled"
    else
        let g:autoformat_enabled = 1
        echo "Autoformat enabled"
    endif
endfunction
noremap  <F6> <Esc>:Autoformat<CR>
noremap! <F6> <Esc>:Autoformat<CR>
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_space = 0
" ]]]

" vim-bookmarks
" [[[
" 重新定义按键映射
let g:bookmark_no_default_key_mappings = 1
nmap <Leader>mm <Plug>BookmarkToggle
nmap <Leader>mi <Plug>BookmarkAnnotate
nmap <Leader>ma <Plug>BookmarkShowAll
nmap <Leader>mj <Plug>BookmarkNext
nmap <Leader>mk <Plug>BookmarkPrev
nmap <Leader>mx <Plug>BookmarkClearAll
" 显示
highlight BookmarkSign ctermbg=NONE ctermfg=160
highlight BookmarkLine ctermbg=194 ctermfg=NONE
let g:bookmark_sign = '⚑'
let g:bookmark_highlight_lines = 1
" 缓存地址
let g:bookmark_auto_save_file = $HOME . '/.vim/.cache/vim_bookmarks'
" ]]]

" vim-commentary
" [[[
autocmd FileType python,shell,coffee setlocal commentstring=#\ %s
autocmd FileType java,c,cpp          setlocal commentstring=//\ %s
" ]]]

" vim-easy-align
" [[[
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" ]]]

" vim-exchange
" [[[
noremap  cx  <Plug>(Exchange)
vnoremap X   <Plug>(Exchange)
noremap  cxc <Plug>(ExchangeClear)
noremap  cxx <Plug>(ExchangeLine)
let g:exchange_no_mappings = 1
" ]]]

" vim-gutentags
" [[[
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project','.idea']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 默认会在当前文件夹产生 .tags 文件
" 将自动生成的 tags 文件全部放入 ~/.vim/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.vim/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args =  ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" ]]]

" vim-javascript
" [[[
let javascript_enable_domhtmlcss = 1
let g:javascript_plugin_flow = 1
" ]]]

" vim-json
" [[[
" 避免引号被隐藏
let g:vim_json_syntax_conceal = 0
" ]]]

" vim-keysound
" [[[
let g:keysound_enable = 1
let g:keysound_theme = 'default'
let g:keysound_py_version = 3
let g:keysound_volume = 1000
" ]]]

" vim-mark
" [[[
" 和 visual-star-search 有 <Leader>* 冲突(MarkSet)
" 以及其他冲突
" 解除 <Leader>*
nmap <Plug>DisableMarkSearchCurrentNext <Plug>MarkSearchCurrentNext
" 解除 <Leader>r
nmap <Plug>DisableMarkRegex <Plug>MarkRegex
" 解除 <Leader>n
nmap <Plug>DisableMarkClear <Plug>MarkClear
" 解除 <Leader>/
nmap <Plug>DisableMarkSearchAnyNext <Plug>MarkSearchAnyNext
" 解除 <Leader>?
nmap <Plug>DisableMarkSearchAnyPrev <Plug>MarkSearchAnyPrev
" 解除 *
nmap <Plug>DisableMarkSearchNext <Plug>MarkSearchNext
" 解除 #
nmap <Plug>DisableMarkSearchPrev <Plug>MarkSearchPrev
" 重新定义映射
nmap <Leader>ms                  <Plug>MarkSet
" ]]]

" vim-markdown
" [[[
" 代码块高亮
let g:vim_markdown_fenced_languages = ['python=py']
let g:vim_markdown_fenced_languages = ['javascript=js']
let g:vim_markdown_fenced_languages = ['c=c']
" 避免标志符号被隐藏
let g:vim_markdown_conceal = 0
let g:vim_markdown_conceal_code_blocks = 0
let g:tex_conceal = ""
let g:vim_markdown_math = 1
" ]]]

" vim-matchup
" [[[
" 跳转成对括号，此处不能用非递归模式，因为在 mathit.vim 里用了非递归映射
nmap M %
autocmd FileType vim let b:match_words =
            \ '\<fu\%[nction]\>:\<retu\%[rn]\>:\<endf\%[unction]\>,' .
            \ '\<\(wh\%[ile]\|for\)\>:\<brea\%[k]\>:\<con\%[tinue]\>:\<end\(w\%[hile]\|fo\%[r]\)\>,' .
            \ '\<if\>:\<el\%[seif]\>:\<en\%[dif]\>,' .
            \ '\<try\>:\<cat\%[ch]\>:\<fina\%[lly]\>:\<endt\%[ry]\>,' .
            \ '\<aug\%[roup]\s\+\%(END\>\)\@!\S:\<aug\%[roup]\s\+END\>'
autocmd FileType python let b:match_words =
            \ '\<if\>:\<el\%[seif]\>,' .
            \ '\<for\>:\<continue\>:\<break\>,' .
            \ '\<while\>:\<continue\>:\<break\>,' .
            \ '\<def\>:\<return\>,' .
            \ '\<try\>:\<except\>:\<finally\>'
" \< \> 标志单词的边界，此处 ; 左边与别的字符直接接触
autocmd FileType javascript let b:match_words =
            \ '=:;,' .
            \ '\<if\>:\<else\>,' .
            \ '\<for\>:\<continue\>:\<break\>,' .
            \ '\<while\>:\<continue\>:\<break\>,' .
            \ '\<function\>:\<return\>,' .
            \ '\<switch\>:\<case\>:\<default\>,' .
            \ '\<\\\*\>:\<\*\\\>'
autocmd FileType c,cpp let b:match_words =
            \ '=:;,' .
            \ '\<if\>:\<else\>,' .
            \ '\<for\>:\<continue\>:\<break\>,' .
            \ '\<do\>:\<while\>:\<continue\>:\<break\>,' .
            \ '\<switch\>:\<case\>:\<default\>,' .
            \ '\<\\\*\>:\<\*\\\>'
" ]]]

" vim-move
" [[[
let g:move_map_keys = 0
let g:move_auto_indent = 1
vmap J <Plug>MoveBlockDown
vmap K <Plug>MoveBlockUp
nmap J <Plug>MoveLineDown
nmap K <Plug>MoveLineUp
"]]]

" vim-nerdtree-syntax-highlight
" [[[
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreePatternMatchHighlightFullName = 1

let s:brown = "905532"
let s:aqua =  "3AFFDB"
let s:blue = "689FB6"
let s:darkBlue = "44788E"
let s:purple = "834F79"
let s:lightPurple = "834F79"
let s:red = "AE403F"
let s:beige = "F5C06F"
let s:yellow = "F09F17"
let s:orange = "D4843E"
let s:darkOrange = "F16529"
let s:pink = "CB6F6F"
let s:salmon = "EE6E73"
let s:green = "8FAA54"
let s:lightGreen = "31B53E"
let s:white = "FFFFFF"
let s:rspec_red = 'FE405F'
let s:git_orange = 'F54D27'

let g:NERDTreeExtensionHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExtensionHighlightColor['css'] = s:blue " sets the color of css files to blue

let g:NERDTreeExactMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreeExactMatchHighlightColor['.gitignore'] = s:git_orange " sets the color for .gitignore files

let g:NERDTreePatternMatchHighlightColor = {} " this line is needed to avoid error
let g:NERDTreePatternMatchHighlightColor['.*_spec\.rb$'] = s:rspec_red " sets the color for files ending with _spec.rb
" ]]]

" vim-signify
" [[[
" 跳转
nmap <C-up>  <Plug>(signify-prev-hunk)
nmap <C-down> <Plug>(signify-next-hunk)
" ! 改成 ~
let g:signify_sign_change = '~'
" 两次按键间隔大于 updatetime 时自动写入磁盘并显示状态
let g:signify_cursorhold_normal = 1
let g:signify_cursorhold_insert = 1
" " 高亮行
highlight DiffAdd           cterm=bold ctermbg=none ctermfg=156
highlight DiffDelete        cterm=bold ctermbg=none ctermfg=167
highlight DiffChange        cterm=bold ctermbg=none ctermfg=227
" 高亮侧栏符号
highlight SignifySignAdd    cterm=bold ctermbg=38   ctermfg=119
highlight SignifySignDelete cterm=bold ctermbg=38   ctermfg=167
highlight SignifySignChange cterm=bold ctermbg=38   ctermfg=227
" VCS
let g:signify_vcs_list = [ 'git']
" Windows 下 VCS 的路径设置
if !has('unix')
    let g:signify_vcs_cmds = {
                \ 'git': '"C:\Program Files (x86)\Git\bin\git.exe" diff --no-color --no-ext-diff -U0 -- %f'
                \ }
endif
" ]]]

" vim-startify
" [[[
noremap <silent> <Space> <Esc>:Startify<CR>
" ]]]

" vim-table-mode
" [[[
" for Markdown
let g:table_mode_corner = '|'
" ]]]

" vim-textobj-user
" [[[
if !empty(glob('~/.vim/plugged/vim-textobj-user'))
" datetime
call textobj#user#plugin('datetime', {
            \   'date': {
            \     'pattern': '\<\d\d\d\d-\d\d-\d\d\>',
            \     'select': ['ad', 'id'],
            \   },
            \   'time': {
            \     'pattern': '\<\d\d:\d\d:\d\d\>',
            \     'select': ['at', 'it'],
            \   },
            \ })
endif
" ]]]

" vim-visual-multi
" [[[
let g:VM_leader = ";"
let g:VM_default_mappings = 0
let g:VM_maps = {}
let g:VM_maps["Select All"] = '<leader>A'
" ]]]

" undotree
" [[[
noremap  <silent> <F3> <Esc>:UndotreeToggle<CR>
noremap! <silent> <F3> <Esc>:UndotreeToggle<CR>
let g:undotree_WindowLayout = 2
let g:undotree_SetFocusWhenToggle = 1
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 25
" ]]]
" ]]]

" ======================================================================
" GVIM Settings
" ======================================================================
" [[[
" gvim 下 TODO: 待验证
if has('gui_running')
    inoremap <S-CR> <Esc>o
    inoremap <C-CR> <Esc>O
    "set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h12
    "set guifont=Fira_Code:h12
endif
" ]]]
"
" =====================================================================
" Cheet Sheet
" =====================================================================
" [[[
" 易混淆快捷键总览
" [[[
" n      <S-h>                  行首
" n      <S-j>             :<vim-move> move up
" n      <S-k>             :<vim-move> move down
" n      <S-l>             行尾
" n      <C-j>             跳转函数定义
" n      <C-k>             跳转帮助
" n      <C-h>             :<vim-sideways> SidewaysLeft<CR>
" n      <C-l>             :<vim-sideways> SidewaysRight<CR>
" n      <C-left>          <Plug>(signify-prev-hunk)
" n      <C-right>         <Plug>(signify-next-hunk)
" n      <M-h>             <Esc><C-w>h
" n      <M-j>             <Esc><C-w>j
" n      <M-k>             <Esc><C-w>k
" n      <M-l>             <Esc><C-w>l
" n      <M-up>            <C-w>+
" n      <M-down>          <C-w>-
" n      <M-left>          <C-w>10<
" n      <M-right>         <C-w>10>
" n      <Leader>ff        <Esc>:LeaderfFile<CR>
" n      <Leader>ft        <Esc>:LeaderfBufTagAll<CR>
" n      <Leader>fb        <Esc>:LeaderfBufferAll<CR>
" n      <Leader>aw        <Esc>:ArgWrap<CR>
" n      <Leader>ms        <Plug>MarkSet
" n      <Leader>mm        <Plug>BookmarkToggle
" n      <Leader>mi        <Plug>BookmarkAnnotate
" n      <Leader>ma        <Plug>BookmarkShowAll
" n      <Leader>mj        <Plug>BookmarkNext
" n      <Leader>mk        <Plug>BookmarkPrev
" n      <Leader>mx        <Plug>BookmarkClearAll
" n      <Leader>ss        :<C-u>SearchCurrentText<CR>
" n      <Leader>ss        :<C-u>SearchCurrentText<CR>
" v      <Leader>sv        :<C-u>SearchVisualText<CR>
" n      <Leader>sm        :Search<space>
" v      <Leader>sv        :<C-u>SearchVisualText<CR>
" n      <Leader>sm        :Search<space>
" v      <Leader>tv        :Ydv<CR>
" n      <Leader>tc        :Ydc<CR>
" n      <Leader>te        sc>:Yde<CR>
" ]]]

" 插件命令小计
" [[[
" gv.vim
" [[[
" GV: 查看 commits
" GV!: 只与当前文件有关的 commits
" ]]]
"
" vim-fugitive
" [[[
" Git: 同一切 git 命令，加 ! 可以在一个临时文件里显示结果 Git add, Git log, Git rm ...
" Gblame: = Git blame
" Gcommit: = Git commit
" Gdelete: = Git delete
" Gdiff: Gvdiff, Gsdiff. 可以选择范围或者直接执行 diffget/diffput 命令消除差异; 也可用 Gread/Gwrite, 但是是全部更新
" Gfetch:
" Ggrep: Ggrep 'find me'
" Glog: Git log
" Gmove: 移动或者重命名
" Gpull:
" Gpush:
" Gstatus: = Git status, 在 status 窗口可以用 - 键快速 add; <Enter> 打开光标下文件; p 相当于 git add --patch; C 会调用 Gcommit(由于本人键映射的原因，C 被映射为其他键了)
" Gread: = Git checkout -- filename
" Gwrite: = Git add
" ]]]
"
" vim-surround
" [[[
" 一般用法: ys**; cs**; ds*
" 端增加空格: ys*<Space><Space>
" ]]]
"
" ]]]
" ]]]
