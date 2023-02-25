if &compatible
  set nocompatible
endif

" Set dein base path (required)
let s:dein_base = expand("$USERDIR/.cache/dein")

" Set dein source path (required)
let s:dein_src = s:dein_base . '/repos/github.com/Shougo/dein.vim'

" git clone unless not installed yet
if !isdirectory(s:dein_src)
  execute '!git clone https://github.com/Shougo/dein.vim' s:dein_src
endif

" Set dein runtime path (required)
execute 'set runtimepath^=' . s:dein_src

if dein#load_state(s:dein_src)
  " Call dein initialization (required)
  call dein#begin(s:dein_src)

  " load with toml files
  let g:rc_dir    = expand("$USERDIR/.vim/rc")
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:toml_lazy = g:rc_dir . '/dein_lazy.toml'

  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:toml_lazy, {'lazy': 1})

  " Finish dein initialization (required)
  call dein#end()
  call dein#save_state()
endif

" Install uninstalled plugins
if dein#check_install()
  call dein#install()
endif

" let g:dein#install_progress_type = 'title'
" let g:dein#enable_notification = 1
filetype plugin indent on
