#!/bin/sh

# Usage:
# $ ~/username/start_myenv.sh

export USERDIR=$(cd $(dirname $0); pwd)
export DOTFILES_ROOT=$USERDIR/.dotfiles

SHELLNAME=$(basename $SHELL)

if [ $SHELLNAME = 'bash' ]; then
    exec $DOTFILES_ROOT/bin/bash_my
elif [ $SHELLNAME = 'zsh' ]; then
    exec ZDOTDIR=$USERDIR $SHELL
fi
