" my filetype file
if exists("did_load_filetypes")
    finish
endif

augroup filetypedetect

	autocmd BufNewFile,BufRead .tern-project setfiletype json
	autocmd BufNewFile,BufRead .jsbeautifyrc setfiletype json
	autocmd BufNewFile,BufRead .eslintrc     setfiletype json
	autocmd BufNewFile,BufRead .jscsrc       setfiletype json

    autocmd BufNewFile,BufRead *.wl       setfiletype mma
    autocmd BufNewFile,BufRead *.wls       setfiletype mma
    autocmd BufNewFile,BufRead .gitignore setfiletype gitignore

augroup END

let did_load_filetypes=1
