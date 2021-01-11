if has('win32')
  set rtp+=~\AppData\Local\nvim
  so ~/AppData/Local/nvim/init.vim
  set guifont=Lucida\ Console:h12
else
  set rtp+=~/.config/nvim
  so ~/.config/nvim/init.vim
endif
