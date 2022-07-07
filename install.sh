#!/bin/sh

stow emacs -t ${HOME}/.emacs.d/
stow stumpwm -t ${HOME}/.stumpwm.d/
stow X -t ${HOME}/
stow qutebrowser -t ${HOME}/.config/qutebrowser/
ln -s $(pwd)/.muttrc /home/${USER}/.muttrc

(cd nix; \
stow home-manager -t ${HOME}/.config/nixpkgs/; \
doas stow config -t /etc/nixos/)
