#!/bin/sh

stow emacs -t ${HOME}/.emacs.d/
stow stumpwm -t ${HOME}/.stumpwm.d/
cd nix
stow home-manager -t ${HOME}/.config/nixpkgs/
doas stow config -t /etc/nixos/
cd -
