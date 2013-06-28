let SessionLoad = 1
if &cp | set nocp | endif
let s:cpo_save=&cpo
set cpo&vim
inoremap <silent> <F10> :make
inoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)a
inoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)a
inoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()a
inoremap <Plug>ZenCodingSplitJoinTagInsert :call zencoding#splitJoinTag()
inoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()a
inoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()a
inoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
inoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
inoremap <Plug>ZenCodingBalanceTagOutwardInsert :call zencoding#balanceTag(-1)
inoremap <Plug>ZenCodingBalanceTagInwardInsert :call zencoding#balanceTag(1)
inoremap <Plug>ZenCodingExpandWord u:call zencoding#expandAbbr(1,"")a
inoremap <Plug>ZenCodingExpandAbbr u:call zencoding#expandAbbr(0,"")a
inoremap <silent> <C-Tab> =UltiSnips_ListSnippets()
map! <S-Insert> <MiddleMouse>
xnoremap 	 :call UltiSnips_SaveLastVisualSelection()gvs
snoremap <silent> 	 :call UltiSnips_ExpandSnippet()
snoremap <silent> <NL> :call UltiSnips_JumpForwards()
snoremap <silent>  :call UltiSnips_JumpBackwards()
xnoremap <silent>  :call multiple_cursors#new("v")
nnoremap <silent>  :call multiple_cursors#new("n")
nmap  :w
vmap c <Plug>ZenCodingCodePretty
nmap A <Plug>ZenCodingAnchorizeSummary
nmap a <Plug>ZenCodingAnchorizeURL
nmap k <Plug>ZenCodingRemoveTag
nmap j <Plug>ZenCodingSplitJoinTagNormal
vmap m <Plug>ZenCodingMergeLines
nmap / <Plug>ZenCodingToggleComment
nmap i <Plug>ZenCodingImageSize
nmap N <Plug>ZenCodingPrev
nmap n <Plug>ZenCodingNext
vmap D <Plug>ZenCodingBalanceTagOutwardVisual
nmap D <Plug>ZenCodingBalanceTagOutwardNormal
vmap d <Plug>ZenCodingBalanceTagInwardVisual
nmap d <Plug>ZenCodingBalanceTagInwardNormal
nmap , <Plug>ZenCodingExpandNormal
vmap , <Plug>ZenCodingExpandVisual
nnoremap   za
map ,r :call RangerChooser()
map Q gq
xmap S <Plug>VSurround
nmap \jt :%!python -m json.tool:set filetype=json
nmap <silent> \/ :nohlsearch
nmap cs <Plug>Csurround
nmap ds <Plug>Dsurround
nmap gx <Plug>NetrwBrowseX
xmap gS <Plug>VgSurround
xmap s <Plug>Vsurround
nmap ySS <Plug>YSsurround
nmap ySs <Plug>YSsurround
nmap yss <Plug>Yssurround
nmap yS <Plug>YSurround
nmap ys <Plug>Ysurround
map <silent> <F10> :make
nnoremap <silent> <Plug>NetrwBrowseX :call netrw#NetrwBrowseX(expand("<cWORD>"),0)
vnoremap <Plug>ZenCodingCodePretty :call zencoding#codePretty()
nnoremap <Plug>ZenCodingAnchorizeSummary :call zencoding#anchorizeURL(1)
nnoremap <Plug>ZenCodingAnchorizeURL :call zencoding#anchorizeURL(0)
nnoremap <Plug>ZenCodingRemoveTag :call zencoding#removeTag()
nnoremap <Plug>ZenCodingSplitJoinTagNormal :call zencoding#splitJoinTag()
vnoremap <Plug>ZenCodingMergeLines :call zencoding#mergeLines()
nnoremap <Plug>ZenCodingToggleComment :call zencoding#toggleComment()
nnoremap <Plug>ZenCodingImageSize :call zencoding#imageSize()
nnoremap <Plug>ZenCodingPrev :call zencoding#moveNextPrev(1)
nnoremap <Plug>ZenCodingNext :call zencoding#moveNextPrev(0)
vnoremap <Plug>ZenCodingBalanceTagOutwardVisual :call zencoding#balanceTag(-2)
nnoremap <Plug>ZenCodingBalanceTagOutwardNormal :call zencoding#balanceTag(-1)
vnoremap <Plug>ZenCodingBalanceTagInwardVisual :call zencoding#balanceTag(2)
nnoremap <Plug>ZenCodingBalanceTagInwardNormal :call zencoding#balanceTag(1)
nnoremap <Plug>ZenCodingExpandWord :call zencoding#expandAbbr(1,"")
nnoremap <Plug>ZenCodingExpandNormal :call zencoding#expandAbbr(3,"")
vnoremap <Plug>ZenCodingExpandVisual :call zencoding#expandAbbr(2,"")
snoremap <silent> <BS> c
snoremap <silent> <C-Tab> :call UltiSnips_ListSnippets()
map <C-PageUp> k_
map <C-PageDown> j_
map <S-Insert> <MiddleMouse>
imap S <Plug>ISurround
imap s <Plug>Isurround
inoremap <silent> 	 =UltiSnips_ExpandSnippet()
inoremap <silent> <NL> =UltiSnips_JumpForwards()
inoremap <silent>  =UltiSnips_JumpBackwards()
imap  :wa
inoremap  u
imap A <Plug>ZenCodingAnchorizeSummary
imap a <Plug>ZenCodingAnchorizeURL
imap k <Plug>ZenCodingRemoveTag
imap j <Plug>ZenCodingSplitJoinTagInsert
imap / <Plug>ZenCodingToggleComment
imap i <Plug>ZenCodingImageSize
imap N <Plug>ZenCodingPrev
imap n <Plug>ZenCodingNext
imap D <Plug>ZenCodingBalanceTagOutwardInsert
imap d <Plug>ZenCodingBalanceTagInwardInsert
imap ; <Plug>ZenCodingExpandWord
imap , <Plug>ZenCodingExpandAbbr
cmap w!! w !sudo tee % >/dev/null
let &cpo=s:cpo_save
unlet s:cpo_save
set autochdir
set background=dark
set backspace=indent,eol,start
set backup
set clipboard=unnamedplus
set errorformat=%f(%l):\ %m
set expandtab
set fileencodings=ucs-bom,utf-8,default,latin1
set guifont=Envy\ Code\ R\ 10
set guioptions=aegit
set helplang=en
set history=50
set hlsearch
set ignorecase
set incsearch
set isident=@,48-57,_,192-255,$
set keywordprg=:help
set laststatus=2
set listchars=tab:>.,trail:.,extends:#,nbsp:.
set makeprg=jsl\ -nologo\ -nofilelisting\ -nosummary\ -nocontext\ -conf\ '/etc/jsl.conf'\ -process\ %
set mouse=a
set ruler
set rulerformat=%30(%=:b%n%y%m%r%w\ %l,%c%V\ %P%)
set runtimepath=~/.vim,~/.vim/bundle/textile.vim,~/.vim/bundle/vim-css3-syntax,~/.vim/bundle/vim-less,/usr/share/vim/vimfiles,/usr/share/vim/vim73,/usr/share/vim/vimfiles/after,~/.vim/bundle/vim-css3-syntax/after,~/.vim/after
set scrolljump=5
set scrolloff=3
set shiftwidth=2
set smartindent
set softtabstop=2
set statusline=%!pyeval('powerline.new_window()')
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
set tabstop=2
set termencoding=utf-8
set undofile
set wildmenu
set wildmode=list:longest,full
set window=69
set winminheight=0
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd /mnt/dropbox/Dropbox/Projects/hawkeye
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 /mnt/dropbox/Dropbox/Projects/hawkeye/lib/hawkeye.coffee
badd +0 /mnt/dropbox/Dropbox/Projects/hawkeye/README.md
badd +0 /mnt/dropbox/Dropbox/Projects/hawkeye/package.json
silent! argdel *
edit /mnt/dropbox/Dropbox/Projects/hawkeye/package.json
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
set nosplitbelow
set nosplitright
wincmd t
set winheight=1 winwidth=1
exe '1resize ' . ((&lines * 34 + 35) / 70)
exe 'vert 1resize ' . ((&columns * 136 + 136) / 273)
exe '2resize ' . ((&lines * 33 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 273)
exe 'vert 3resize ' . ((&columns * 136 + 136) / 273)
argglobal
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal cindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=j1,J1
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
setlocal commentstring=//%s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'javascript'
setlocal filetype=javascript
endif
set foldcolumn=1
setlocal foldcolumn=1
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!pyeval('powerline.statusline(3)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'javascript'
setlocal syntax=javascript
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
2
normal! zo
let s:l = 11 - ((10 * winheight(0) + 17) / 34)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
11
normal! 019|
wincmd w
argglobal
edit /mnt/dropbox/Dropbox/Projects/hawkeye/README.md
setlocal keymap=
setlocal noarabic
setlocal noautoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=fb:*,fb:-,fb:+,n:>
setlocal commentstring=>\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=
setlocal expandtab
if &filetype != 'markdown'
setlocal filetype=markdown
endif
set foldcolumn=1
setlocal foldcolumn=1
setlocal foldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=tcqln
setlocal formatlistpat=^\\s*\\d\\+\\.\\s\\+\\|^[-*+]\\s\\+
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=
setlocal matchpairs=(:),{:},[:],<:>
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=htmlcomplete#CompleteTags
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!pyeval('powerline.statusline(2)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'markdown'
setlocal syntax=markdown
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
83
normal! zo
83
normal! zo
let s:l = 84 - ((35 * winheight(0) + 16) / 33)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
84
normal! 030|
wincmd w
argglobal
edit /mnt/dropbox/Dropbox/Projects/hawkeye/lib/hawkeye.coffee
setlocal keymap=
setlocal noarabic
setlocal autoindent
setlocal balloonexpr=
setlocal nobinary
setlocal bufhidden=
setlocal buflisted
setlocal buftype=
setlocal nocindent
setlocal cinkeys=0{,0},0),:,0#,!^F,o,O,e
setlocal cinoptions=
setlocal cinwords=if,else,while,do,for,switch
setlocal colorcolumn=
setlocal comments=:#
setlocal commentstring=#\ %s
setlocal complete=.,w,b,u,t,i
setlocal concealcursor=
setlocal conceallevel=0
setlocal completefunc=
setlocal nocopyindent
setlocal cryptmethod=
setlocal nocursorbind
setlocal nocursorcolumn
set cursorline
setlocal cursorline
setlocal define=
setlocal dictionary=
setlocal nodiff
setlocal equalprg=
setlocal errorformat=Error:\ In\ %f\\,\ %m\ on\ line\ %l,Error:\ In\ %f\\,\ Parse\ error\ on\ line\ %l:\ %m,SyntaxError:\ In\ %f\\,\ %m,%-G%.%#
setlocal expandtab
if &filetype != 'coffee'
setlocal filetype=coffee
endif
set foldcolumn=1
setlocal foldcolumn=1
setlocal nofoldenable
setlocal foldexpr=0
setlocal foldignore=#
setlocal foldlevel=0
setlocal foldmarker={{{,}}}
set foldmethod=indent
setlocal foldmethod=indent
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal foldtext=foldtext()
setlocal formatexpr=
setlocal formatoptions=croql
setlocal formatlistpat=^\\s*\\d\\+[\\]:.)}\\t\ ]\\s*
setlocal grepprg=
setlocal iminsert=0
setlocal imsearch=2
setlocal include=
setlocal includeexpr=
setlocal indentexpr=GetCoffeeIndent(v:lnum)
setlocal indentkeys=0{,0},:,0#,!^F,o,O,e,0],0),0.,=else,=when,=catch,=finally
setlocal noinfercase
setlocal iskeyword=@,48-57,_,192-255
setlocal keywordprg=
setlocal nolinebreak
setlocal nolisp
set list
setlocal list
setlocal makeprg=coffee\ -c\ \ $*\ hawkeye.coffee
setlocal matchpairs=(:),{:},[:]
setlocal modeline
setlocal modifiable
setlocal nrformats=octal,hex
set number
setlocal number
setlocal numberwidth=4
setlocal omnifunc=javascriptcomplete#CompleteJS
setlocal path=
setlocal nopreserveindent
setlocal nopreviewwindow
setlocal quoteescape=\\
setlocal noreadonly
setlocal norelativenumber
setlocal norightleft
setlocal rightleftcmd=search
setlocal noscrollbind
setlocal shiftwidth=2
setlocal noshortname
setlocal smartindent
setlocal softtabstop=2
setlocal nospell
setlocal spellcapcheck=[.?!]\\_[\\])'\"\	\ ]\\+
setlocal spellfile=
setlocal spelllang=en
setlocal statusline=%!pyeval('powerline.statusline(1)')
setlocal suffixesadd=
setlocal swapfile
setlocal synmaxcol=3000
if &syntax != 'coffee'
setlocal syntax=coffee
endif
setlocal tabstop=2
setlocal tags=
setlocal textwidth=0
setlocal thesaurus=
setlocal undofile
setlocal nowinfixheight
setlocal nowinfixwidth
set nowrap
setlocal nowrap
setlocal wrapmargin=0
let s:l = 7 - ((6 * winheight(0) + 34) / 68)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 016|
wincmd w
2wincmd w
exe '1resize ' . ((&lines * 34 + 35) / 70)
exe 'vert 1resize ' . ((&columns * 136 + 136) / 273)
exe '2resize ' . ((&lines * 33 + 35) / 70)
exe 'vert 2resize ' . ((&columns * 136 + 136) / 273)
exe 'vert 3resize ' . ((&columns * 136 + 136) / 273)
tabnext 1
if exists('s:wipebuf')
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToO
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
