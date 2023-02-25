"======================================================
" Imported from $VIMRUNTIME/vimrc_example.vim.
"======================================================
"
" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start		" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set wildmenu		" display completion matches in a status line
set encoding=utf-8 " set encoding explicitly

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

filetype plugin indent on

"======================================================
" Original settings
"======================================================
set notitle
set number
set list
" set listchars=tab:\ \ ,extends:<,trail:\ 
set listchars=tab:>-,trail:-
set laststatus=2
set statusline=[%L]\ %t\ %y%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%r%m%=%c:%l/%L

" tabs
set tabstop=2 shiftwidth=2 softtabstop=2 expandtab autoindent smartindent

" search
set ignorecase smartcase nohlsearch incsearch

" map
noremap  
noremap!  

"======================================================
" Syntax highlight
"======================================================
syntax on

highlight LineNr ctermfg=darkyellow    " 行番号
highlight NonText ctermfg=darkgrey
highlight Folded ctermfg=blue
highlight SpecialKey cterm=underline ctermfg=darkgrey

" 全角スペースを視覚化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=white
match ZenkakuSpace /　/
