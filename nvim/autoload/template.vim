" ============================================================================
" FileName: template.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" Description: modified from vim-template
" ============================================================================

function s:EscapeRegex(raw)
  return escape(a:raw, '/')
endfunction

function s:TExpand(variable, value)
  silent! execute "%s/\\V%" . s:EscapeRegex(a:variable) . "%/" .  s:EscapeRegex(a:value) . "/g"
endfunction

function s:TExpandVars()
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
  call s:TExpand("DAY",   day)
  call s:TExpand("YEAR",  year)
  call s:TExpand("DATE",  date)
  call s:TExpand("TIME",  time)
  call s:TExpand("USER",  user)
  call s:TExpand("FDATE", fdate)
  call s:TExpand("MONTH", month)
  call s:TExpand("MONTHSHORT", monshort)
  call s:TExpand("MONTHFULL",  monfull)
  call s:TExpand("FILE",  filen)
  call s:TExpand("FFILE", filec)
  call s:TExpand("FDIR",  fdir)
  call s:TExpand("EXT",   filex)
  call s:TExpand("MAIL",  email)
  call s:TExpand("HOST",  hostn)
  call s:TExpand("GUARD", guard)
  call s:TExpand("CLASS", class)
  call s:TExpand("MACROCLASS", macroclass)
  call s:TExpand("CAMELCLASS", camelclass)
  call s:TExpand("LICENSE", license)
endfunction

function s:TPutCursor()
  0  " Go to first line before searching
  if search("%HERE%", "W")
    let column = col(".")
    let lineno = line(".")
    s/%HERE%//
    call cursor(lineno, column)
  endif
endfunction

function s:NeuterFileName(filename)
  let neutered = fnameescape(a:filename)
  return neutered
endfunction

function s:TLoadTemplate(template)
  let tpath = s:NeuterFileName(a:template)
  execute "keepalt 0r " . tpath
  call s:TExpandVars()

  " Loading a template into an empty buffer leaves an extra blank line at the
  " bottom, delete it
  let lastlnum = len(readfile(tpath)) + 1
  if empty(trim(getline(lastlnum))) 
    execute len(readfile(tpath)) + 1 . "d"
  endif

  call s:TPutCursor()
  setlocal nomodified
endfunction

function template#TLoad(ext)
  if empty(a:ext)
    let tfiles = filter(
          \ globpath(&rtp, 'templates/=template=*', 0, 1),
          \ { _,v -> expand('%') =~ matchstr(v, '=template=\zs.*\ze') . '$' }
          \ )
  else
    let tfiles = globpath(&rtp, 'templates/=template=.'.a:ext, 0, 1)
  endif
  if empty(tfiles)
    call util#show_msg('No templates for this filetype', 'error')
  else
    let tfile = sort(tfiles, { a,b -> len(b) - len(a) })[0]
    call s:TLoadTemplate(tfile)
  endif
endfunction
