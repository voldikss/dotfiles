#! /bin/bash

# copy files
cp -f ../bash/.bashrc $HOME
cp -f ../inputrc/.inputrc $HOME
cp -f ../git/.gitconfig $HOME
cp -f ../intellij/.ideavimrc $HOME
 # vim
cp -f ../vim/.vimrc.gitbash $HOME/.vimrc
cp -rf ../vim/.vim $HOME
vim -c ':PlugInstall --sync | :qa!'

# git
`git config --global core.editor vim`

# pip
`pip config set global.index-url https://mirrors.sjtug.sjtu.edu.cn/pypi/web/simple`
`pip install numpy requests autopep8 flake8 Pillow yapf`
