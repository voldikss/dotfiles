" @Author: voldikss
" @Date: 2019-01-04 16:32:15
" @Last Modified by: voldikss
" @Last Modified time: 2019-03-24 11:58:09

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

" If Windows
if has('win32') || has('win64') || has('win32unix')
    " If Windows NeoVim
    if has('nvim')
        let g:python3_host_prog='D:/Applications/Python36/python.exe'
    " If Windows Git Bash Vim
    elseif has('win32unix')
        set pythonthreedll=/d/Applications/Python36/python36.dll
    " If Windows Vim/GVim
    else
        set pythonthreedll=D:\Applications\Python36\python36.dll
    endif
" If Linux
else
    let g:python3_host_prog='/usr/bin/python3'
endif

" GVIM Settings
if has('gui_running')
    inoremap <S-CR> <Esc>o
    inoremap <C-CR> <Esc>O
    set encoding=utf-8
    " au GUIEnter * simalt ~x " 窗口启动时自动最大化
    set guioptions-=m " 隐藏菜单栏
    set guioptions-=T " 隐藏工具栏
    set guioptions-=L " 隐藏左侧滚动条
    set guioptions-=r " 隐藏右侧滚动条
    set guioptions-=b " 隐藏底部滚动条
    set guifont=Monaco\ for\ Powerline:h10:b
    " set guifont=DejaVu\ Sans\ Mono\ for\ Powerline:h11:b
    source $VIMRUNTIME/delmenu.vim
    source $VIMRUNTIME/menu.vim
    language messages zh_CN.utf-8
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
" Language pack
Plug 'sheerun/vim-polyglot'
" Cpp
Plug 'octol/vim-cpp-enhanced-highlight', {'for': 'cpp'}
" Debug
Plug 'cpiger/NeoDebug'
" Markdown
Plug 'godlygeek/tabular', {'for': 'markdown'}
Plug 'plasticboy/vim-markdown',{'for':'markdown'}
Plug 'mzlogin/vim-markdown-toc', {'for':'markdown'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }}
Plug 'dhruvasagar/vim-table-mode',{'for':'markdown'}
" HTML
Plug 'rstacruz/sparkup',{ 'for':'html' }
Plug 'othree/html5.vim',{'for':'html'}
Plug 'mattn/emmet-vim',  {'for': ['html','vue','css','wxml']}
Plug 'alvan/vim-closetag', {'for': ['html', 'xml']}
" JSON
Plug 'elzr/vim-json',{'for':'json'}
" Python
if has('nvim')
    Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
endif
" Wolfram
Plug 'voldikss/vim-mma',{'for':'mma'}
" Language Template
Plug 'aperezdc/vim-template'
" ]]]

" [[[ Completion
" NEOVIM "
if has('nvim')
    Plug 'Shougo/denite.nvim'
    Plug 'sirver/ultisnips'
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    Plug 'Shougo/echodoc.vim'
    Plug 'Shougo/neco-vim'
    Plug 'neoclide/coc-neco'
" VIM"
else
    "=======================Use Coc================================
    Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
    Plug 'Shougo/neco-vim'
    Plug 'neoclide/coc-neco'

    "=======================Use AutoComplPop=======================
    " Plug 'vim-scripts/AutoComplPop'

    "=======================Use Deoplete===========================
    " set pyxversion=3
    " let g:python3_host_prog='D:/Applications/Python36/python.exe'
    " Plug 'Shougo/deoplete.nvim'
    " Plug 'roxma/nvim-yarp'
    " Plug 'roxma/vim-hug-neovim-rpc'
    " Plug 'Rip-Rip/clang_complete'
    " Plug 'deoplete-plugins/deoplete-jedi'
    " Plug 'davidhalter/jedi'
    " Plug 'fszymanski/deoplete-emoji'
    " Plug 'Shougo/neopairs.vim'
    " Plug 'Shougo/echodoc.vim'
    " let g:deoplete#enable_at_startup = 1
endif
" ]]]
" ]]]

" [[[ ColorScheme && Format && Display && Interface
" 彩虹括号
Plug 'luochen1990/rainbow'
" CSS 颜色高亮
Plug 'ap/vim-css-color'
" 格式化
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
" 界面
Plug 'justinmk/vim-dirvish'
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
" Xterm Color preview
Plug 'guns/xterm-color-table.vim'
" ]]]

" [[[ Integrations && Enhancements
" [[[ Git
" Git operators
Plug 'tpope/vim-fugitive'
" GitHub(fugitive :Gbrose support)
Plug 'tpope/vim-rhubarb'
" Git commit browser
Plug 'cohama/agit.vim'
" Git diff
Plug 'mhinz/vim-signify'
" Gist
Plug 'mattn/gist-vim'
Plug 'mattn/webapi-vim'
" Quick comment
Plug 'tpope/vim-commentary'
" ]]]

" [[[ Enhancements
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
" Plug 'inkarkat/vim-mark'
" Plug 'inkarkat/vim-ingo-library'
" LeetCode
Plug 'iandingx/leetcode.vim'
" Shanbay
Plug 'voldikss-bot/sb.vim'
" Quick run
Plug 'xuhdev/SingleCompile'
" Keep window when buffer was deleted
Plug 'moll/vim-bbye'
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
set updatetime=100
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
" colorscheme gruvbox
colorscheme molokai

set termguicolors

set background=dark
set t_Co=256

set title
set ruler
set showcmd
set noshowmode
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

" Files & Format [[[
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

" 合并两行中文时，不在中间加空格
set formatoptions+=B
" ]]]

" Others [[[
set completeopt-=noselect
set completeopt-=preview

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
" nnoremap Q <Nop>

" 清楚搜索高亮
inoremap <esc> <Esc>:noh<CR>
nnoremap <esc> <Esc>:noh<CR>

" 行首和行末快捷键
noremap H ^
noremap L $

" U 为 redo
noremap U <C-r>
" 跳转标记更方便
noremap ' `

" C-j 跳转函数定义: Go to definition
noremap <C-j> <C-]>
" C-k 跳转帮助: Help
noremap <C-k> K

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

" 切换 buffer
nnoremap <C-h>     :bprev<CR>
nnoremap <C-l>     :bnext<CR>
" 删除当前 buffer
noremap <silent> <Leader>d :Bdelete!<CR>

" 切换窗口
noremap <M-h> <Esc><C-w>h
noremap <M-j> <Esc><C-w>j
noremap <M-k> <Esc><C-w>k
noremap <M-l> <Esc><C-w>l

" 调整窗口大小
noremap <M-up> <C-w>+
noremap <M-down> <C-w>-
noremap <M-left> <C-w>5<
noremap <M-right> <C-w>5>

" tab 新建
noremap  <C-t>     <Esc>:tabnew<CR>
noremap! <C-t>     <Esc>:tabnew<CR>
" tab 移动
nnoremap gj :tabnext<CR>
nnoremap gk :tabprevious<CR>

" 调整缩进后自动选中
vnoremap < <gv
vnoremap > >gv

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

" Insert 模式 ;* 的映射
inoremap ;; <End>;
inoremap ;, <End>,
inoremap ;a <Home>
inoremap ;e <End>
inoremap ;h <Left>
inoremap ;j <Down>
inoremap ;k <Up>
inoremap ;l <Right>
inoremap ;o <Esc>o
inoremap ;O <Esc>O
inoremap ;u <C-u>
inoremap ;c <Esc>cc
inoremap ;i <Esc>I

" Insert 模式 jj 替换 Esc
inoremap jj <Esc>
inoremap jk <Esc>

" 快速退出
nnoremap <Leader>q  <Esc>:q<CR>
" 快速退不做任何保存
nnoremap <Leader>Q  <Esc>:qa!<CR>
" 快速保存
noremap <Leader>w  <Esc>:w<CR>
" 快速保存并退出
noremap <Leader>W  <Esc>:wq<CR>

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
" Windows:
if has('win32') || has('win64')
    noremap <silent> <Leader>n <Esc>:vert term bash<CR>
    noremap <silent> ,n <Esc>:term bash<CR>
" Linux:
else
    if executable("zsh")
        noremap <silent> <Leader>n <Esc>:vsplit term://zsh<CR>
        noremap <silent> ,n <Esc>:edit term://zsh<CR>
    else
        noremap <silent> <Leader>n <Esc>:vsplit term://bash<CR>
        noremap <silent> ,n <Esc>:edit term://bash<CR>
    endif
endif

" 安装、更新、删除插件
nnoremap <Leader><Leader>i :PlugInstall<CR>
nnoremap <Leader><Leader>u :PlugUpdate<CR>
nnoremap <Leader><Leader>c :PlugClean<CR>
command! PU PlugUpdate | PlugUpgrade
command! PS PlugStatus
command! PC PlugClean
" ]]]

" ======================================================================
" Auto Commands
" ======================================================================
" [[[
" Foldmethod: vimrc 采用 marker 折叠方式
" [[[
augroup Foldmethod
    autocmd!
    autocmd BufNewFile,BufRead *.vimrc setlocal foldmarker=[[[,]]]
    autocmd BufNewFile,BufRead *.vimrc setlocal foldmethod=marker
    autocmd BufNewFile,BufRead *.vimrc setlocal foldtext='+'.substitute(getline(v:foldstart),'[\[\"]','','g').v:folddashes
augroup END
" ]]]

" SourceVimrc: 保存 vimrc 时自动 source
" [[[
augroup SourceVimrc
    autocmd!
    autocmd BufWritePost ~/.vimrc nested source $MYVIMRC
augroup END
" ]]]

" DisableAutoComment: 禁止自动插入注释
" [[[
augroup DisableAutoComment
    autocmd!
    autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
augroup END
" ]]]

" LineNumber: 不同模式行号显示
" [[[
augroup LineNumber
    autocmd!
    autocmd InsertEnter * :set norelativenumber number
    autocmd InsertLeave * :set relativenumber
augroup END
" ]]]

" EqualWindowsSize: 终端窗口大小变化时保持所有窗口同等大小
" [[[
augroup EqualWindowsSize
    autocmd!
    autocmd VimResized * exec "normal \<c-w>="
augroup END
" ]]]

" LastPosition: 打开自动定位到最后编辑的位置
" [[[
augroup LastPosition
    autocmd!
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
" ]]]

" KeywordHighlight: 关键词高亮
" [[[
augroup KeywordHighlight
    autocmd!
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|Todo\|todo\|FIXME\|CHANGED\|note\|NOTE\|Note\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
augroup END
" ]]]

" AutoChdir: 自动进入当前文件的目录
" [[[
augroup AutoChdir
    autocmd!
    autocmd BufEnter * silent! lcd %:p:h
augroup END
" ]]]
" ]]]

" ======================================================================
" Functions
" ======================================================================
" [[[
" InitGitignore: 个人 gitignore 默认配置
" [[[
command! InitGitignore call InitGitignore()
autocmd BufNewFile .gitignore exec "call InitGitignore()"
function! InitGitignore()
    if &filetype ==# 'gitignore'
        let s:ignore = [
                    \'test.*', 'tmp.*',
                    \ '.tags', '*.pyc', '*.o', '*.out', '*.log',
                    \ '.idea/', '/.idea',
                    \ 'build/',
                    \ '__pycache__'
                    \]
        let s:lines = line('$')
        normal O
        call append(0, s:ignore)
    endif
endfunction
" ]]]

" QuickRun: 一键运行
" [[[
command! QuickRun call QuickRun(0)
noremap  <silent> <F5> <Esc>:call QuickRun(0)<CR>
noremap! <silent> <F5> <Esc>:call QuickRun(0)<CR>
noremap <silent> <Leader>rs <Esc>:call QuickRun(0)<CR>
" 异步执行
noremap <silent> <Leader>ra <Esc>:call QuickRun(1)<CR>
function! QuickRun(async)
    exec 'w'
    if &filetype == 'html' || &filetype == 'htmldjango'
        call BrowserOpen(expand("%:p"))
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif a:async == 1
        echo "QuickRunAsync (Use :SCViewResultAsync to view the result)"
        exec "SCCompileRunAsync"
    else
        exec "SCCompileRun"
    endif
endfunction
" ]]]

" FileExplore: 在文件浏览器中打开当前目录
" [[[
noremap <F2> <Esc>:call FileExplore()<CR>
command! FileExplore call FileExplore()
function! FileExplore()
    let l:path = expand(getcwd())
    call BrowserOpen(l:path)
endfunction
" ]]]

" BrowserOpen: 打开文件或网址
" [[[
command! -nargs=+ BrowserOpen call BrowserOpen(<q-args>)
function! BrowserOpen(obj)
    " windows(mingw)
    if has('win32') || has('win64') || has('win32unix')
        let cmd = 'rundll32 url.dll,FileProtocolHandler ' . a:obj
    elseif has('mac') || has('macunix') || has('gui_macvim') || system('uname') =~? '^darwin'
        let cmd = 'open ' . a:obj
    elseif executable('xdg-open')
        let cmd = 'xdg-open ' . a:obj
    else
        echoerr "No browser found, please contact the developer."
    endif

    if exists('*jobstart')
        call jobstart(cmd)
    elseif exists('*job_start')
        call job_start(cmd)
    else
        call system(cmd)
    endif
endfunction
" ]]]

" TabMessage: 捕获 Ex 命令的输出
" [[[
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

" NormalMapForEnter: Normal 模式下回车键映射
" [[[
nnoremap <expr> <CR> NormalMapForEnter() . "\<Esc>"
function! NormalMapForEnter()
    if &filetype ==# 'quickfix'
    " quickfix 窗口正常
        return '\<CR>'
    " 在语句末尾加分号
    elseif index(['c', 'cpp', 'cs', 'javascript', 'java'],&filetype) >= 0
        let l:line = getline('.')
        if l:line != '' && l:line !~ '^\s\+$' && index([';', '{', '(', '\'], l:line[-1:]) < 0
            return 'A;'
        endif
    " 阻止 <CR> 进入下一行
    else
        return '\<Nop>'
    endif
endfunction
" ]]]

" InsertMapForEnter: Insert 模式下回车键映射
" [[[
inoremap <expr> <CR> InsertMapForEnter()
function! InsertMapForEnter()
    " 补全菜单
    if pumvisible()
        return "\<C-y>"
    " 自动缩进大括号 {}
    elseif strcharpart(getline('.'),getpos('.')[2]-1,1) == '}'
        return "\<CR>\<Esc>O"
    elseif strcharpart(getline('.'),getpos('.')[2]-1,2) == '</'
        return "\<CR>\<Esc>O"
    else
        return "\<CR>"
    endif
endfunction
" ]]]

" MapForSemicolonEnter: Insert 模式 ;<CR> 插入 ;
" [[[
inoremap <expr> ;<CR> MapForSemicolonEnter()
function! MapForSemicolonEnter()
    if (getline('.')[-1:] != ';') && (index(['c', 'cpp', 'cs', 'javascript', 'java'],&filetype) >= 0)
        return "\<End>;\<CR>"
    else
        return "\<Esc>o"
endfunction
" ]]]

" MapForSemicolonP: Insert 模式 ;p 行尾插入 {}
" [[[
inoremap <expr> ;p MapForSemicolonP()
function! MapForSemicolonP()
    if index(['c', 'cpp', 'cs', 'javascript', 'java'],&filetype) >= 0
        return "\<End>{}\<Left>"
    else
        return ";p"
    endif
endfunction
" ]]]
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
" 快速 grep
noremap <Leader>gg :call Grep(shellescape(expand("<cword>")))<CR>
" Grep 命令
command! -nargs=+ Grep call Grep(<q-args>)
function! Grep(string)
    if executable('rg')
        execute "AsyncRun! rg -n " . a:string . " * "
    elseif has('win32') || has('win64')
        execute "AsyncRun! -cwd=<root> findstr /n /s /C:" . a:string
    else
        execute "AsyncRun! -cwd=<root> grep -n -s -R " . a:string . " * " . "--exclude='*.so' --exclude='.git' --exclude='.idea' --exclude='.cache' --exclude='.IntelliJIdea' --exclude='*.py[co]'"
    endif
endfunction
" ]]]

" auto-pairs
" [[[
autocmd FileType html let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''",'{%':'%}', '<!--':'-->'}
autocmd FileType javascript,css,c,cpp let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''",'/*':'*/'}
autocmd FileType markdown let b:AutoPairs ={'(':')', '[':']', '{':'}',"'":"'",'"':'"', "`":"`", '```':'```', '"""':'"""', "'''":"'''", '*':'*','~':'~'}
autocmd FileType vim let b:AutoPairs = {'(':')', '[':']', '{':'}',"'":"'", "`":"`", '<':'>'}

" 防止 C-h 被映射为 <BS>
let g:AutoPairsMapCh = 0
let g:AutoPairsMapSpace = 0
" Alt-e 快速加括号
let g:AutoPairsShortcutFastWrap = '<M-e>'
" Alt-p 开关插件
let g:AutoPairsShortcutToggle = 'Disable'
" 解除一系列映射键
let g:AutoPairsShortcutJump = 'Disable'
let g:AutoPairsShortcutBackInsert = 'Disable'
let g:AutoPairsMapCR = 'Disable'
" ]]]

" coc
" [[[
" Use <Tab> and <S-Tab> for navigate completion list:
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Close preview window when completion is done.
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" 语法检查跳转
nmap <M-n> <Plug>(coc-diagnostic-next)
nmap <M-p> <Plug>(coc-diagnostic-prev)
" 定义声明实现跳转
nmap <Leader>cd <Plug>(coc-definition)
nmap <Leader>ci <Plug>(coc-implementation)
nmap <Leader>cr <Plug>(cc-references)
nmap <Leader>cf <Plug>(coc-fix-current)
" ]]]

" Deoplete
" [[[
if exists('g:loaded_deoplete')

endif
" ]]]

" dict.vim
" [[[
" --普通模式下，<Leader>tt 即可翻译光标下的文本，并在命令行回显
nmap <silent> <Leader>tt <Plug>DictSearch
" --可视化模式下，<Leader>tt 即可翻译选中的文本，并在命令行回显
vmap <silent> <Leader>tt <Plug>DictVSearch
" --普通模式下，<Leader>tw 即可翻译光标下的文本，并且在Dict新窗口显示
nmap <silent> <Leader>tw <Plug>DictWSearch
" --可视化模式下，<Leader>tw 即可翻译选中的文本，并且在Dict新窗口显示
vmap <silent> <Leader>tw <Plug>DictWVSearch
" --普通模式下，<Leader>tr 即可翻译光标下的单词，并替换为翻译的结果
nmap <silent> <Leader>tr <Plug>DictRSearch
" --可视化模式下，<Leader>tr 即可翻译光标下的单词，并替换为翻译的结果
vmap <silent> <Leader>tr <Plug>DictRVSearch
" --<Leader>td 命令行翻译
nmap <Leader>td :Dict<Space>
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
let g:goyo_width = '85'
let g:goyo_height = '85%'
let g:goyo_linenr = 1
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

" markdown-preview.nvim
" [[[
let g:mkdp_auto_close = 0
"" ]]]

" NeoDebug
" [[[
let g:neodbg_keymap_continue           = '<F5>'         " run or continue
let g:neodbg_keymap_toggle_breakpoint  = '<F9>'         " toggle breakpoint on current line
let g:neodbg_keymap_next               = '<F10>'        " next
let g:neodbg_keymap_terminate_debugger = '<F12>'        " terminate debugger
" following are unuseful
let g:neodbg_keymap_run_to_cursor      = '<Nop1>'      " run to cursor (tb and c)
let g:neodbg_keymap_jump               = '<Nop2>'    " set next statement (tb and jump)
let g:neodbg_keymap_step_into          = '<Nop3>'        " step into
let g:neodbg_keymap_step_out           = '<Nop4>'      " setp out
let g:neodbg_keymap_print_variable     = '<Nop5>'        " view variable under the cursor
let g:neodbg_keymap_stop_debugging     = '<Nop6>'        " stop debugging (kill)
let g:neodbg_keymap_toggle_console_win = '<Nop7>'         " toggle console window
noremap <F8> <Esc>:NeoDebug ./a.out<CR>
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

" SingleCompile
" [[[
if has("unix")
    let s:common_run_command = "./a.out"
    let s:common_out_file = "a.out"
else
    let s:common_run_command = "./a.exe"
    let s:common_out_file = "a.exe"
endif

" Only for c/cpp: start time optimization
if index(['c', 'cpp'], &filetype) >= 0 && exists("g:loaded_SingleCompile")
    call SingleCompile#SetCompilerTemplate('c', 'gcc', 'GNU C Compiler','gcc', '-g', s:common_run_command)
    call SingleCompile#SetOutfile('c', 'gcc', s:common_out_file)
    call SingleCompile#ChooseCompiler('c', 'gcc')

    call SingleCompile#SetCompilerTemplate('cpp', 'g++', 'GNU CPP Compiler','g++', '-g', s:common_run_command)
    call SingleCompile#SetOutfile('cpp', 'g++', s:common_out_file)
    call SingleCompile#ChooseCompiler('cpp', 'g++')
endif
" ]]]

" sparkup
" [[[
" default: <c-e>
let g:sparkupExecuteMapping = '<c-i>'
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
" for c, cpp, c#, object-c
let g:formatterpath=['/home/voldikss/Applications/clang+llvm-7.0.1-x86_64-linux-gnu-ubuntu-18.04/bin']
" ]]]

" vim-bookmarks
" [[[
" 重新定义按键映射
let g:bookmark_no_default_key_mappings = 1
nmap <Leader>bm <Plug>BookmarkToggle
nmap <Leader>bi <Plug>BookmarkAnnotate
nmap <Leader>ba <Plug>BookmarkShowAll
nmap <Leader>bn <Plug>BookmarkNext
nmap <Leader>bp <Plug>BookmarkPrev
nmap <Leader>bc <Plug>BookmarkClearAll
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
autocmd FileType java,c,cpp,json     setlocal commentstring=//\ %s
" ]]]

" vim-cpp-enhanced-highlight
" [[[
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_experimental_simple_template_highlight = 1
let g:cpp_concepts_highlight = 1
" ]]]

" vim-easy-align
" [[[
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
" ]]]

" vim-exchange
" [[[
nmap cx <Plug>(Exchange)
xmap X <Plug>(Exchange)
nmap cxc <Plug>(ExchangeClear)
nmap cxx <Plug>(ExchangeLine)
" ]]]

" vim-gutentags
" [[[
" gutentags 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project','.idea']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags'

" 默认会在当前文件夹产生 .tags 文件
" 将自动生成的 tags 文件全部放入 ~/.vim/tags 目录中，避免污染工程目录
if has('unix')
    let s:vim_tags = expand('~/.vim/.cache/tags')
    let g:gutentags_cache_dir = s:vim_tags
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args =  ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
" ]]]

" vim-json
" [[[
" 避免引号被隐藏
let g:vim_json_syntax_conceal = 0
" ]]]

" vim-mark
" [[[
" 和 visual-star-search 有 <Leader>* 冲突(MarkSet)
" 以及其他冲突
" 解除 <Leader>*
map <Plug>DisableMarkSearchCurrentNext <Plug>MarkSearchCurrentNext
" 解除 <Leader>r
map <Plug>DisableMarkRegex <Plug>MarkRegex
" 解除 <Leader>n
map <Plug>DisableMarkClear <Plug>MarkClear
" 解除 <Leader>/
map <Plug>DisableMarkSearchAnyNext <Plug>MarkSearchAnyNext
" 解除 <Leader>?
map <Plug>DisableMarkSearchAnyPrev <Plug>MarkSearchAnyPrev
" 解除 *
map <Plug>DisableMarkSearchNext <Plug>MarkSearchNext
" 解除 #
map <Plug>DisableMarkSearchPrev <Plug>MarkSearchPrev
" 重新定义映射
map <Leader>ms                  <Plug>MarkSet
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

" vim-templates
" [[[
let g:templates_directory = ['~/.vim/templates']
let g:templates_no_autocmd = 1
let g:templates_no_builtin_templates = 1
" ]]]

" vim-textobj-user
" [[[
if exists("*textobj#user#plugin")
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
" n      <M-n>             <Plug>(coc-diagnostic-next)
" n      <M-p>             <Plug>(coc-diagnostic-next)
" n      <M-up>            <C-w>+
" n      <M-down>          <C-w>-
" n      <M-left>          <C-w>10<
" n      <M-right>         <C-w>10>
" n      <Leader>ff        <Esc>:LeaderfFile<CR>
" n      <Leader>ft        <Esc>:LeaderfBufTagAll<CR>
" n      <Leader>fb        <Esc>:LeaderfBufferAll<CR>
" n      <Leader>aw        <Esc>:ArgWrap<CR>
" n      <Leader>ms        <Plug>MarkSet
" n      <Leader>bm        <Plug>BookmarkToggle
" n      <Leader>bi        <Plug>BookmarkAnnotate
" n      <Leader>ba        <Plug>BookmarkShowAll
" n      <Leader>bn        <Plug>BookmarkNext
" n      <Leader>bp        <Plug>BookmarkPrev
" n      <Leader>bc        <Plug>BookmarkClearAll
" n      <Leader>ss        :<C-u>SearchCurrentText<CR>
" n      <Leader>ss        :<C-u>SearchCurrentText<CR>
" v      <Leader>sv        :<C-u>SearchVisualText<CR>
" n      <Leader>sm        :Search<space>
" v      <Leader>sv        :<C-u>SearchVisualText<CR>
" n      <Leader>sm        :Search<space>
" ]]]
" ]]]
