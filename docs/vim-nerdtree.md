### 安装
` Plugin 'scrooloose/nerdtree' 
### 配置
` "F2键快速调出和隐藏它"`<br>
` map <F2> :NERDTreeToggle<CR>`<br>
` " 显示行号`<br>
` let NERDTreeShowLineNumbers=1`<br>
` let NERDTreeAutoCenter=1`<br>
` " 是否显示隐藏文件`<br>
` let NERDTreeShowHidden=0`<br>
` " 设置宽度`<br>
` let NERDTreeWinSize=28`<br>
` " 在终端启动vim时，共享NERDTree`<br>
` let g:nerdtree_tabs_open_on_console_startup=1`<br>
` " 忽略以下文件的显示`<br>
` let NERDTreeIgnore=['\.pyc','\~$','\.swp']`<br>
` " 显示书签列表`<br>
` let NERDTreeShowBookmarks=1`<br>
` "打开vim时自动打开nerdtree`<br>
` autocmd vimenter * NERDTree`<br>

### 用法
>o       在已有窗口中打开文件、目录或书签，并跳到该窗口<br>
>go      在已有窗口 中打开文件、目录或书签，但不跳到该窗口<br>
>t       在新 Tab 中打开选中文件/书签，并跳到新 Tab<br>
>T       在新 Tab 中打开选中文件/书签，但不跳到新 Tab<br>
>i       split 一个新窗口打开选中文件，并跳到该窗口<br>
>gi      split 一个新窗口打开选中文件，但不跳到该窗口`<br>
>s       vsplit 一个新窗口打开选中文件，并跳到该窗口<br>
>gs      vsplit 一个新 窗口打开选中文件，但不跳到该窗口<br>
>!       执行当前文件<br>
>O       递归打开选中 结点下的所有目录<br>
>x       合拢选中结点的父目录<br>
>X       递归 合拢选中结点下的所有目录<br>
>e       Edit the current dif<br>

>D       删除当前书签<br>
>P       跳到根结点<br>
>p       跳到父结点<br>
>K       跳到当前目录下同级的第一个结点<br>
>J       跳到当前目录下同级的最后一个结点<br>
>k       跳到当前目录下同级的前一个结点<br>
>j       跳到当前目录下同级的后一个结点`br>>
>C       将选中目录或选中文件的父目录设为根结点<br>
>u       将当前根结点的父目录设为根目录，并变成合拢原根结点<br>
>U       将当前根结点的父目录设为根目录，但保持展开原根结点<br>
>r       递归刷新选中目录<br>
>R       递归刷新根结点<br>
>m       显示文件系统菜单 #！！！然后根据提示进行文件的操作如新建，重命名等<br>
>cd      将 CWD 设为选中目录`br>>
>I       切换是否显示隐藏文件<br>
>f       切换是否使用文件过滤器<br>
>F       切换是否显示文件<br>
>B       切换是否显示书签<br>

><C-h> <C-l> 文件预览窗口的宽度<br>
>q       关闭 NerdTree 窗口<br>
>?       切换是否显示 Quick Help<br>
### 链接 https://github.com/scrooloose/nerdtree
