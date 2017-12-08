set nocompatible                " must be first, since it affects
                                " subsequent initialization

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if (&t_Co > 2 || has("gui_running")) && !exists("syntax_on")
  syntax on
endif

" profile start syntastic.log
" profile! file */syntastic/*

" Syntax highlighting doesn't work well with vimdiff.
if &diff
  syntax off
endif

if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif

filetype plugin indent on

" ===============================================
" OPTIONS
" ===============================================

set   hidden                    " allow hidden buffers
set   history=1000
set   undolevels=1000
set   viminfo='20,\"50          " how much session information vim stores
set nobackup                    " don't backup
set   directory=~/.tmp,~/tmp,/var/tmp,/tmp
set   fileformats+=mac
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
set   backspace=indent,eol,start
set   cino=(0,:0,l1             " modifications of default C indentation
"set   comments=b:#,fb:-,n:>,n:)
set   expandtab                 " expand tabs
set nojoinspaces                " don't add 2 spaces to start sentence
set   shiftwidth=2              " autoindent spacing
set   softtabstop=2             " <Tab> counts for 2 spaces while editing
set   tabstop=8                 " how much to indent
set   textwidth=72              " width of screen to type on
"XXX: vim 7.1 has a script that fucks up formatoptions
"set   formatoptions=tcrqn2      " autoformat comments (e.g. autowrap)
set   formatoptions+=2j         " format sentences from 2nd line

set   background=dark           " type in the dark
set   t_Co=256                  " more colors
set   laststatus=2              " always show last status
set   ruler                     " always show cursor position
set   showcmd                   " Show partial commands in the status line
set   showmode                  " Show the current mode
set   report=0                  " always show changes
set   display=lastline          " show partial lines

set   esckeys                   " allow use of cursor keys in insert mode
set   hlsearch                  " highlight search terms
set   incsearch                 " show search matches as you type
set   showmatch                 " show matching brackets for parentheses
set   pastetoggle=<F2>          " when in insert mode, press <F2> to go
                                " to paste mode

" ===============================================
" MAPPINGS
" ===============================================

map ^ :noh<CR>

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
cnoremap    <C-A>   <Home>
cnoremap    <C-E>   <End>


" ===============================================
" AUTOCOMMANDS
" ===============================================

au BufRead,BufNewFile *.ll       set filetype=llvm
au BufRead,BufNewFile *.proto    set filetype=proto
au BufRead,BufNewFile *.cu       set filetype=c
au BufRead,BufNewFile *.avdl     set filetype=java

" Default FileType settings
autocmd FileType asm              set com= noet sts=8
autocmd FileType c,cpp,python set fo-=t fo+=crqo sts=4
autocmd FileType html             set noet sts=2 sw=2
autocmd FileType gitconfig        set noet sw=8 sts=8
autocmd FileType go               set noet sw=8 tw=0
autocmd FileType less             set sts=2 sw=2
autocmd FileType java             set sts=2 sw=2
autocmd FileType javascript       set sts=2 sw=2 tw=0
autocmd FileType make             set noet sts=4 tw=0
autocmd FileType proto            set sts=2 fo-=t fo+=crqo
autocmd FileType thrift           set sts=2
autocmd FileType sh               set sw=4 sts=8
autocmd FileType yacc             set noet sts=8 tw=0

" ===============================================
" PLUGINS
" ===============================================

let g:rustfmt_autosave = 1
" let g:rustfmt_fail_silently = 1
let g:ale_rust_cargo_use_check = 1
let g:racer_cmd = expand("~/.cargo/bin/racer")
" let $RUST_SRC_PATH = expand("~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src/")

let g:javascript_plugin_flow = 1
let g:jsx_ext_required = 0

let g:ale_fixers = {
\  'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1

let g:neoformat_enabled_css = ['prettier']
let g:neoformat_enabled_less = ['prettier']
autocmd BufWritePre *.{css,less} Neoformat
let g:neoformat_enabled_json = ['prettier']
" autocmd BufWritePre *.{json} Neoformat

let g:sqlutil_align_comma = 1
