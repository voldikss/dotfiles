" ============================================================================
" FileName: tasks.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ============================================================================

let s:asynctasks_macros = [
  \["VIM_FILEPATH",  "File name of current buffer with full path",             "/home/voldikss/dotfiles/home/.config/nvim/autoload/coc/source/tasks.vim"],
  \["VIM_FILENAME",  "File name of current buffer without path",               "tasks.vim"],
  \["VIM_FILEDIR",   "Full path of current buffer without the file name",      "/home/voldikss/dotfiles/home/.config/nvim/autoload/coc/source"],
  \["VIM_FILEEXT",   "File extension of current buffer",                       ".vim"],
  \["VIM_FILETYPE",  "File type (value of &ft in vim)",                        "vim"],
  \["VIM_FILENOEXT", "File name of current buffer without path and extension", "tasks"],
  \["VIM_PATHNOEXT", "Current file name with full path but without extension", "/home/voldikss/dotfiles/home/.config/nvim/autoload/coc/source/tasks"],
  \["VIM_CWD",       "Current directory",                                      "/home/voldikss/dotfiles/home/.config/nvim/autoload/coc/source"],
  \["VIM_RELDIR",    "File path relativize to current directory",              "."],
  \["VIM_RELNAME",   "File name relativize to current directory",              "tasks.vim"],
  \["VIM_CWORD",     "Current word under cursor",                              "VIM_PRONAME"],
  \["VIM_CFILE",     "Current filename under cursor",                          "VIM_PRONAME"],
  \["VIM_CLINE",     "Cursor line number in current buffer",                   "28"],
  \["VIM_VERSION",   "Value of v:version",                                     "800"],
  \["VIM_SVRNAME",   "Value of v:servername for +clientserver usage",          "/tmp/nvimfOsenC/0"],
  \["VIM_COLUMNS",   "How many columns in vim's screen",                       "153"], ["VIM_LINES",     "How many lines in vim's screen",                         "40"], ["VIM_GUI",       "Is running under gui ?",                                 "0"], ["VIM_ROOT",      "Project root directory",                                 "/home/voldikss/dotfiles"], ["VIM_DIRNAME",   "Name of current directory",                              "source"], ["VIM_PRONAME",   "Name of current project root directory",                 "dotfiles"], ["VIM_PROFILE",   "Current building profile (debug/release/...)",           "debug"],
  \]

function! coc#source#tasks#init() abort
  return {
    \ 'priority': 99,
    \ 'shortcut': 'TASKS',
    \ 'filetypes': ['tasks'],
    \ 'triggerCharacters': ['(', '$']
    \ }
endfunc

function! coc#source#tasks#complete(opt, cb) abort
  " NOTE: use coc-tasks instead
  " let completion = []
  " for macro in s:asynctasks_macros
  "   let prechar = getline('.')[getpos('.')[2]-2]
  "   let item = {
  "     \'abbr': macro[0],
  "     \'word': prechar == '$' ? '('.macro[0].')' : macro[0],
  "     \'documentation': [{"filetype": 'markdown', 'content': macro[1] . "\ne.g. `" . macro[2] . '`'}],
  "     \}
  "   call add(completion, item)
  " endfor
  " call a:cb(completion)
endfunc
