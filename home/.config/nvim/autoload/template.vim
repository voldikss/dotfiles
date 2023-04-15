" ============================================================================
" FileName: template.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: modified from vim-template
" ============================================================================

function s:escape_regex(raw)
  return escape(a:raw, '/')
endfunction

function s:expand(variable, value)
  silent! execute "%s/\\V%" . s:escape_regex(a:variable) . "%/" .  s:escape_regex(a:value) . "/g"
endfunction

function s:expand_vars()
  " Date/time values
  let day        = strftime("%d")
  let year       = strftime("%Y")
  let month      = strftime("%m")
  let monshort   = strftime("%b")
  let monfull    = strftime("%B")
  let time       = strftime("%H:%M")
  let date       = exists("g:dateformat") ? strftime(g:dateformat) :
    \ (year . "-" . month . "-" . day)
  let fdate      = date . " " . time
  let filen      = expand("%:t:r:r:r")
  let filex      = expand("%:e")
  let filec      = expand("%:t")
  let fdir       = expand("%:p:h:t")
  let hostn      = hostname()
  let user       = exists("g:username") ? g:username :
    \ (exists("g:user") ? g:user : $USER)
  let email      = exists("g:email") ? g:email : (user . "@" . hostn)
  let guard      = toupper(substitute(filec, "[^a-zA-Z0-9]", "_", "g"))
  let class      = substitute(filen, "\\([a-zA-Z]\\+\\)", "\\u\\1\\e", "g")
  let macroclass = toupper(class)
  let camelclass = substitute(class, "_", "", "g")

  " Define license variable
  if executable('licensee') && g:templates_use_licensee
    let projectpath = shellescape(expand("%:p:h"))
    if executable('git') && g:templates_detect_git
      let isgitrepo = matchstr(system("git rev-parse --is-inside-work-tree"), "true")
      if isgitrepo ==# "true"
        let projectpath = system("git rev-parse --show-toplevel")
      endif
    endif
    " Returns 'None' if the project does not have a license.
    let license = matchstr(system("licensee detect " . projectpath), '^License:\s*\zs\S\+\ze\%x00')
  endif
  if !exists("license") || license == "None" || license == ""
    let license = "MIT"
  endif

  " Finally, perform expansions
  call s:expand("DAY",   day)
  call s:expand("YEAR",  year)
  call s:expand("DATE",  date)
  call s:expand("TIME",  time)
  call s:expand("USER",  user)
  call s:expand("FDATE", fdate)
  call s:expand("MONTH", month)
  call s:expand("MONTHSHORT", monshort)
  call s:expand("MONTHFULL",  monfull)
  call s:expand("FILE",  filen)
  call s:expand("FFILE", filec)
  call s:expand("FDIR",  fdir)
  call s:expand("EXT",   filex)
  call s:expand("MAIL",  email)
  call s:expand("HOST",  hostn)
  call s:expand("GUARD", guard)
  call s:expand("CLASS", class)
  call s:expand("MACROCLASS", macroclass)
  call s:expand("CAMELCLASS", camelclass)
  call s:expand("LICENSE", license)
  " 执行系统命令展开
  " e.g. %(node -v)% for .nvmrc
  silent! execute "%s/%\\((.*)\\)%/\\=trim(system(submatch(1)))/g"
endfunction

function s:put_cursor()
  0  " Go to first line before searching
  if search("%HERE%", "W")
    let column = col(".")
    let lineno = line(".")
    s/%HERE%//
    call cursor(lineno, column)
  endif
endfunction

function s:neuter_filename(filename)
  let neutered = fnameescape(a:filename)
  return neutered
endfunction

function s:load_template(template)
  let tpath = s:neuter_filename(a:template)
  execute "keepalt 0r " . tpath
  call s:expand_vars()

  " Loading a template into an empty buffer leaves an extra blank line at the
  " bottom, delete it
  let lastlnum = len(readfile(tpath)) + 1
  if empty(trim(getline(lastlnum)))
    execute len(readfile(tpath)) + 1 . "d"
  endif

  call s:put_cursor()
  setlocal nomodified
endfunction

function! s:get_all_templates() abort
  return globpath(&rtp, 'templates/*.template', 0, 1) + globpath(&rtp, 'templates/.*.template', 0, 1)
endfunction

function! s:trim_suffix(str) abort
  return substitute(a:str, '.template$', '', 'g')
endfunction

function! s:is_matched(template_full_path) abort
  let template_filename = fnamemodify(a:template_full_path, ':t')
  return expand('%') =~ s:trim_suffix(template_filename)
endfunction

function template#load(ext)
  if empty(a:ext)
    let tfiles = filter(
          \ s:get_all_templates(),
          \ { _,v -> s:is_matched(v) }
          \ )
  else
    let tfiles = globpath(&rtp, printf('templates/.%s.template', a:ext), 0, 1)
  endif
  if empty(tfiles)
    call util#show_msg('No templates for this filetype', 'error')
  else
    let tfile = sort(tfiles, { a,b -> len(b) - len(a) })[0]
    call s:load_template(tfile)
  endif
endfunction
