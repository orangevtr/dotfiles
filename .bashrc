if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export USERDIR=${USERDIR:-$HOME}

[ -r $USERDIR/.shrc_common ] && source $USERDIR/.shrc_common

PS1='\[\e[0m\]\[\e[32m\][\u@\h \W]${WINDOW:+"[$WINDOW]"}\$\[\e[0m\] '

export LANG=en_US.UTF-8
