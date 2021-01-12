if has('win32')
  set rtp+=~\AppData\Local\nvim
  set guifont=Lucida\ Console:h12
  set pythonthreedll=D:/Applications/Python39/python39.dll
  so ~/AppData/Local/nvim/init.vim
else
  set rtp+=~/.config/nvim
  so ~/.config/nvim/init.vim
endif
