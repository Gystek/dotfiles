stow emacs -t ${HOME}/.emacs.d/
stow stumpwm -t ${HOME}/.stumpwm.d/
ln -s $(pwd)/home.nix ${HOME}/.config/nixpkgs/home.nix
