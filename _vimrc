" ===============================================
" OPTIONS
" ===============================================

" Use vim settings, rather then vi settings (much better!) This must be
" first, because it changes other options as a side effect.
set nocompatible

filetype on
filetype indent on              " turn on default filetype indentation

set   hidden                    " allow hidden buffers
set   history=1000
set   undolevels=1000
set   viminfo='20,\"50          " how much session information vim stores
set nobackup                    " don't backup
set   directory=~/.tmp,~/tmp,/var/tmp,/tmp
                                " store swap files in one of these directories
"set   mouse=a                   " use the mouse
"set   mousehide                 " hide the mouse pointer when typing
set   shell=/bin/bash           " set the shell to be bash
set   suffixes=.aux,.bak,.dvi,.gz,.h,.idx,.o,.ps,.swp,.tar
set   tags=./tags,./TAGS,tags,TAGS,tags;/
"set   wildignore=*.o            " tab-complete ignore these files
set   wildmode=longest:full     " complete common string, then wildmenu
set   wildmenu                  " show possible completion matches

set   autoindent                " automatically indent
set   backspace=2               " allow backspacing over indent, sol, eol
set   cino=(0,:0,l1             " modifications of default C indentation
"set   comments=b:#,fb:-,n:>,n:)
set   expandtab                 " expand tabs
set nojoinspaces                " don't add 2 spaces to start sentence
set   shiftwidth=4              " autoindent spacing
set   softtabstop=4             " <Tab> counts for 2 spaces while editing
set   tabstop=8                 " how much to indent
set   textwidth=72              " width of screen to type on
"XXX: vim 7.1 has a script that fucks up formatoptions
"set   formatoptions=tcrqn2      " autoformat comments (e.g. autowrap)
set   formatoptions+=2          " format sentences from 2nd line

set   background=dark           " type in the dark
set   ruler                     " always show cursor position
set   showcmd                   " Show partial commands in the status line
set   showmode                  " Show the current mode
set   report=0                  " always show changes

set   esckeys                   " allow use of cursor keys in insert mode
set   hlsearch                  " highlight search terms
set   incsearch                 " show search matches as you type
set   showmatch                 " show matching brackets for parentheses
set   pastetoggle=<F2>          " when in insert mode, press <F2> to go
                                " to paste mode

" ===============================================
" MAPPINGS
" ===============================================

  map ^ :nohlsearch<CR>

" Make both backspace keys work as backspace.
  map! <C-?> <BS>
  map! <C-H> <BS>

" Disable suspend via ^Z. Instead just go to the shell.
  map <C-Z> :shell

" Mappings for timestamping. This uses an internal command.
" map ,L  1G/Last update:\s*/e+1<CR>CYDATE<ESC>
" map ,,L 1G/Last change:\s*/e+1<CR>CYDATE<ESC>

" Titlise selected text
  vmap ,t :s/\<\(.\)\(\k*\)\>/\u\1\L\2/g<bar>:nohlsearch<cr>
" Titlise a line
  nmap ,t :s/.*/\L&/<bar>:s/\<./\u&/g<bar>:nohlsearch<cr>

" Squeeze empty lines - Converts blocks of empty lines within
" current visual into one empty line.
  map ,Sel :g/^$/,/./-j

" Squeeze blank lines - Converts blocks of blank lines within
" current visual into one empty line.
  map ,Sbl :g/^$/,/./-j

" Mappings for C-style comment headers.
  map <F5> i/*****<Space>*****/<Esc>7ha<Space>

" Mappings to comment blocks of code.
"  vmap ,# "zdi#if 0<CR><C-R>z#endif<CR><ESC>
"  vmap ,* :s/#\(if 0\\|endif\)\n//<CR>
  map ,/ :s/^/\/\//<CR> <Esc>:nohlsearch<CR>
  map ,# :s/^/#/<CR> <Esc>:nohlsearch <CR>
  map ," :s/^/\"/<CR> <Esc>:nohlsearch<CR>
  map ,% :s/^/%/<CR> <Esc>:nohlsearch<CR>
" Mapping to uncomment blocks of code.
  map ,c :s/^\/\/\\|^--\\|^> \\|^[#"%!;]//<CR> <Esc>:nohlsearch<CR>

" Emacs/bash style command-line
  cnoremap      <C-A>   <Home>
  cnoremap      <C-E>   <End>


" ===============================================
" AUTOCOMMANDS
" ===============================================

" Remove ALL auto-commands in case the vimrc gets read again.
  autocmd!

  au BufRead,BufNewFile *.ll       set filetype=llvm
  au BufRead,BufNewFile *.proto    set filetype=proto

  "TODO Skeletons -
  "     autocmd BufNewFile *.c  Or ~/skel/skeleton.c

  " Default FileType settings
  autocmd FileType asm              set com= noet ts=8
  autocmd FileType c,cpp,yacc,lex,python set fo-=t fo+=crqo
  autocmd FileType html             set noet sw=2 ts=4
  autocmd FileType java             set com=sr:/*,mb:*,elx:*/
  autocmd FileType make             set noet sw=8 ts=8 tw=0
  autocmd FileType ocaml            set com=sr:(*,mb:*,elx:*)
  autocmd FileType sh               set sw=4 ts=8


" ===============================================
" CTAGS
" ===============================================

" Rebuild the tag file in the dir of the current source file.
"  nmap ,t :!(cd %:p:h;ctags *.[ch])&

"  set tags=tags

" ===============================================
" COLORS
" ===============================================

" If the filename matches a syntax file, we turn on highlighting.
  if has("syntax")
    syntax on
  endif

" We know xterm-debian is a color terminal
  if &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
    set t_Co=16
    set t_Sf=[3%dm
    set t_Sb=[4%dm
  endif
