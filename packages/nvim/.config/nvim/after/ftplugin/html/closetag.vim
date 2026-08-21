" ============================================================================
" FileName: closetag.vim
" Author: voldikss <dyzplus@gmail.com>
" GitHub: https://github.com/voldikss
" ModifiedFrom: https://github.com/alvan/vim-closetag
" ============================================================================

if exists('b:did_ftplugin_closetag')
  finish
endif
let b:did_ftplugin_closetag = 1

let g:closetag_emptyTags_caseSensitive = 0
let g:closetag_regions = {
      \ 'typescript.tsx': 'jsxRegion,tsxRegion',
      \ 'javascript.jsx': 'jsxRegion',
      \ }

let b:closetag_emptyTags = '^\(area\|base\|br\|col\|command\|embed\|hr\|img\|input\|keygen\|link\|meta\|param\|source\|track\|wbr\)$'
let b:closetag_firstWasEndTag = 0
let b:closetag_html_mode = 1
let b:closetag_haveAtt = 0
let b:closetag_use_xhtml = &filetype == 'xhtml' ? 1 : 0

inoremap <silent> <buffer> > ><Esc>:call <SID>CloseIt()<CR>

command! -nargs=* -complete=file CloseTagEnableBuffer let b:closetag_disabled = 0
command! -nargs=* -complete=file CloseTagDisableBuffer let b:closetag_disabled = 1
command! -nargs=* -complete=file CloseTagToggleBuffer let b:closetag_disabled = exists('b:closetag_disabled') && b:closetag_disabled ? 0 : 1

" Script rgular expresion used. Documents those nasty criters
" Don't check for quotes around attributes!!!
let s:ReqAttrib = '\(\(\s\|\n\)\+\([^>= \t]\+=[^>&]\+\)\(\s\|\n\)*\)\+\(\/\)\@\<!>'
let s:EndofName = '\($\|\s\|>\)'

function! s:SavePos()
  return 'call cursor('.line('.').','. col('.'). ')'
endfunction

function! s:Handler(xml_tag, isHtml)
  let text = 0
  if a:isHtml == 1 && exists("*HtmlAttribCallback")
    let text = HtmlAttribCallback(a:xml_tag)
  elseif exists("*XmlAttribCallback")
    let text = XmlAttribCallback(a:xml_tag)
  endif
  if text != '0'
    execute "normal! i " . text ."\<Esc>l"
  endif
endfunction

" Gets the tagname from startinsert position.
"
" Now lets go for the name part. The namepart are xmlnamechars which
" is quite a big range. We assume that everything after '<' or '</'
" until the first 'space', 'forward slash' or '>' ends de name part.
function! s:TagName(from)
  let l:end = match(getline('.'), s:EndofName,a:from)
  let l:tag = strpart(getline('.'),a:from, l:end - a:from)
  if strridx(l:tag, "\\") == strlen(l:tag) - 1
    let l:tag = ''
  endif

  return l:tag
endfunction

" Looks for attribute in open tag
" expect cursor to be on <
function! s:HaveAtt()
  "Check if this open tag has attributes
  let l:line = line('.') | let l:col = col('.')
  if search(b:closetag_tagName . s:ReqAttrib,'W') > 0
    if l:line == line('.') && l:col == (col('.')-1)
      let b:closetag_haveAtt = 1
    endif
  endif
endfunction

" Should the tag be treated as an non closing) tag?
" check the current tag with the set of tags defined in b:closetag_emptyTags
" closetag_emptyTags_caseSensitive defines if the check is case sensitive
function! s:AsEmpty()
  return g:closetag_emptyTags_caseSensitive == 1
        \ ? b:closetag_tagName =~# b:closetag_emptyTags
        \ : b:closetag_tagName =~? b:closetag_emptyTags
endfunction

" Is there a tag under the cursor?
" Set bufer wide variable
"  - b:closetag_firstWasEndTag
"  - b:closetag_tagName
"  - b:gotoCloseTag (if the tag under the cursor is one)
"  - b:gotoOpenTag  (if the tag under the cursor is one)
" on exit
"    - returnrns 1 (true)  or 0 (false)
"    - position is at '<'
function! s:FindTag()
  let b:closetag_firstWasEndTag = 0
  let b:closetag_haveAtt = 0
  let l:haveTag = 0
  let l:stayCol = col('.')

  "Lets find forward a < or a >.  If we first find a > we might be in a tag.
  "If we find a < first or nothing we are definitly not in a tag

  " if getline('.')[col('.') - 1] != '>'
  " search('[<>]','W')
  " endif

  if getline('.')[col('.') - 1] == '>'
    " we don't work with:
    " blank string, empty tags, jsp %> tags, php ?> tags, operator =>, operator ->
    if index([' ', '/', '%', '?', '=', '-'], getline('.')[col('.')-2]) >= 0
      return l:haveTag
    endif
  else
    return l:haveTag
  endif

  if search('[<>]','bW') >=0
    if getline('.')[col('.')-1] == '<'
      if getline('.')[col('.')] == '/'
        let b:closetag_firstWasEndTag = 1
        let b:gotoCloseTag = s:SavePos()
      elseif getline('.')[col('.')] == '?' ||  getline('.')[col('.')] == '!'
        "we don't deal with processing instructions or dtd
        "related definitions
        return l:haveTag
      else
        let b:gotoOpenTag = s:SavePos()
      endif
    else
      return l:haveTag
    endif
  else
    return l:haveTag
  endif

  "we don't deal with the first > in quotes
  let l:str = strpart(getline('.'),col('.'), l:stayCol - col('.'))
  if (strlen(l:str) - strlen(substitute(substitute(substitute(l:str, '\\\\', '', 'g'), '\\"', '', 'g'), '"', '', 'g'))) % 2
    return l:haveTag
  endif

  "we have established that we are between something like
  "'</\?[^>]*>'

  let b:closetag_tagName = s:TagName(col('.') + b:closetag_firstWasEndTag)
  "echo 'Tag ' . b:closetag_tagName

  "begin: gwang customization, do not work with an empty tag name
  if b:closetag_tagName == ''
    return l:haveTag
  endif
  "end: gwang customization, do not work with an empty tag name

  let l:haveTag = 1
  if b:closetag_firstWasEndTag == 0
    call s:HaveAtt()
    if exists('b:gotoOpenTag') && b:gotoOpenTag != ''
      execute b:gotoOpenTag
    endif
  endif
  return l:haveTag
endfunction

function! s:InValidRegion()
  let l:regions = get(g:closetag_regions, &filetype, '')
  if l:regions == ''
    " no restrictions? no problem
    return 1
  endif

  " make sure we're in a valid region type
  let l:regionStack = synstack(line('.'), col('.'))
  for id in l:regionStack
    let l:regionName = synIDattr(id, "name")
    if stridx(l:regions, l:regionName) != -1
      return 1
    endif
  endfor

  " not in a valid region; cancel
  return 0
endfunction

function! s:CloseIt()
  if !(exists("b:closetag_disabled") && b:closetag_disabled) && s:InValidRegion()
    let l:restore = s:SavePos()

    let l:endOfLine = ((col('.')+1) == col('$'))
    if col('.') > 1 && getline('.')[col('.')-2] == '>'
      let l:line = line('.')
      "Multiline request. <t>></t> -->
      "<t>
      "        cursor comes here
      "</t>
      normal! h
      if s:FindTag()
        if b:closetag_firstWasEndTag == 0
          if l:line > 0 && l:line != line('.')
            execute "normal! " . l:line . "gg"
          endif
          if exists('b:did_indent') && b:did_indent == 1
            execute "normal! 2f>a\<Cr>\<Esc>k$i\<Cr>\<Esc>$"
          else
            execute "normal! 2f>a\<Cr>\<Esc>k$i\<Cr>\<Esc>>>$"
          endif
          call setline('.', strpart(getline('.'), 0, strlen(getline('.'))-1))

          if col('.') >= col('$') | startinsert | else | startinsert! | endif
          return
        endif
      endif
    elseif s:FindTag()
      if b:closetag_firstWasEndTag == 0
        execute "silent normal! />\<Cr>"
        if b:closetag_html_mode && s:AsEmpty()
          if b:closetag_haveAtt == 0
            call s:Handler(b:closetag_tagName, b:closetag_html_mode)
          endif
          if b:closetag_use_xhtml
            execute "normal! i/\<Esc>l"
          endif
          if l:endOfLine
            startinsert!
            return
          else
            normal! l
            startinsert
            return
          endif
        else
          if b:closetag_haveAtt == 0
            call s:Handler(b:closetag_tagName, b:closetag_html_mode)
          endif
          execute "normal! a</" . b:closetag_tagName . ">\<Esc>F<"
          startinsert
          return
        endif
      endif
    endif
    execute l:restore
  endif

  if (col('.')+1) == col("$")
    startinsert!
  else
    normal! l
    startinsert
  endif
endfunction
