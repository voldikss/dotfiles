" my filetype file
if exists("did_load_my_filetypes")
  finish
endif

augroup filetypedetect
  autocmd BufNewFile,BufRead .tern-project     setfiletype json
  autocmd BufNewFile,BufRead .jsbeautifyrc     setfiletype json
  autocmd BufNewFile,BufRead .eslintrc         setfiletype json
  autocmd BufNewFile,BufRead .jscsrc           setfiletype json

  autocmd BufNewFile,BufRead npm-debug.log     setfiletype npm-debug-log
  autocmd BufNewFile,BufRead .npmignore        setfiletype conf
  autocmd BufNewFile,BufRead npmrc,.npmrc      setfiletype npmrc


  autocmd BufNewFile,BufRead *.cjson           setfiletype jsonc
  autocmd BufNewFile,BufRead coc-settings.json setfiletype jsonc
  autocmd BufNewFile,BufRead config*.json      setfiletype jsonc

  autocmd BufNewFile,BufRead *.wl              setfiletype mma
  autocmd BufNewFile,BufRead *.wls             setfiletype mma

  autocmd BufNewFile,BufRead *.gitignore       setfiletype gitignore

  autocmd BufNewFile,BufRead *.log             setfiletype log
  autocmd BufNewFile,BufRead *_log             setfiletype log

  autocmd BufNewFile,BufRead *.clang-format    setfiletype yaml

  autocmd BufNewFile,BufRead *.masm            setfiletype masm

  autocmd BufNewFile,BufRead *.pro             setfiletype qmake

  autocmd BufNewFile,BufRead cgdbrc            setfiletype vim

  autocmd BufNewFile,BufRead *.inc             setfiletype cpp

  autocmd BufNewFile,BufRead *.h               setfiletype c   " do not set to cpp

  autocmd BufNewFile,BufRead .tasks,tasks.ini  setfiletype tasks

  autocmd BufNewFile,BufRead .ccls             setfiletype ccls

  autocmd BufNewFile,BufRead *.toml,Gopkg.lock,Cargo.lock,*/.cargo/config,*/.cargo/credentials,Pipfile setfiletype toml
augroup END

let did_load_my_filetypes=1
