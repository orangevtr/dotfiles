#!/usr/bin/env bash

info () {
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    echo ''
    exit
}

cd $(dirname "$0")

DOTFILES_ROOT=$(pwd -P)
export USERDIR=${USERDIR:-$HOME}

set -e

install_dotfiles () {
    info 'install dotfiles'
    for f in .aliases .bashrc .screenrc .vimrc .zshrc .shrc_common .gitconfig .tmux.conf; do
        info "- $USERDIR/$f -> $DOTFILES_ROOT/$f"
        ln -sf $DOTFILES_ROOT/$f $USERDIR/$f
    done

    # tmp
    mkdir -p $USERDIR/tmp

    success 'dotfiles'
}

setup_vim_env () {
    info 'setup vim env'

    info '- install plug.vim'
    curl -fLo $USERDIR/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

    info '- install and build vimproc before installing modules with neobundle'
    # install vimproc before installing modules with neobundle
    # c.f. https://github.com/Shougo/vimproc.vim#manual-install
    git clone https://github.com/Shougo/vimproc.vim $USERDIR/.vim/bundle/vimproc.vim
    cd $USERDIR/.vim/bundle/vimproc.vim && make
    for d in autoload lib plugin; do
        mkdir -p $USERDIR/.vim/$d
        cp -pr $USERDIR/.vim/bundle/vimproc.vim/$d/* $USERDIR/.vim/$d
    done

    info '- install packages with neobundle'
    # install packages with neobundle
    git clone https://github.com/Shougo/neobundle.vim $USERDIR/.vim/bundle/neobundle.vim
    VIMRC=$USERDIR/.vimrc
    vim -N -u $VIMRC -c "try | NeoBundleUpdate! $* | finally | qall! | endtry" \
                -U NONE -i NONE -V1 -e -s

    success 'vim env'
}

setup_anyenv () {
    info 'setup anyenv'

    # Add anyenv
    info '- install anyenv'
    git clone https://github.com/riywo/anyenv $USERDIR/.anyenv

    echo 'export PATH=$USERDIR/.anyenv/bin:$PATH' >> $USERDIR/.shrc_common
    echo 'eval "$(anyenv init -)"' >> $USERDIR/.shrc_common

    info '- rbenv(Ruby)'
    $BASH_BIN -l -c "anyenv install rbenv"
    $BASH_BIN -l -c "rbenv install 2.4.0"

    info '- ndenv(node.js)'
    $BASH_BIN -l -c "anyenv install ndenv"
    $BASH_BIN -l -c "ndenv install v6.10.0"

    success 'anyenv'
}

# parse options
while getopts ":-:" opt; do
    case "$opt" in
        -)
            case "${OPTARG}" in
                with-anyenv)
                    WITH_ANYENV=1
                    ;;
            esac
            ;;
    esac
done

install_dotfiles
setup_vim_env

[ -n "$WITH_ANYENV" ] && [ "$WITH_ANYENV" -eq 1 ] && setup_anyenv

echo ''
echo 'bootstrap completed.'
