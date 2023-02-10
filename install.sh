#!/bin/sh

linkto() {
    local from="$2"
    local to="$1"

    if [ ! -f "$to" ]
    then
	ln -s "$(pwd)/$from" "$to"
    fi
}

stow emacs -t ${HOME}/.emacs.d/
stow X -t ${HOME}/
stow git -t ${HOME}
stow kakoune -t ${HOME}/.config/kak

linkto ${HOME}/.exrc .exrc
linkto ${HOME}/.gnus .gnus
linkto ${HOME}/.bashrc .bashrc
stow fish -t ${HOME}/.config/fish/
