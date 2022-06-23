{ config, pkgs, ... }:

{

  home.username = "gustek";
  home.homeDirectory = "/home/gustek";

  home.stateVersion = "21.05";

  home.packages = with pkgs; [
    capture
    shotgun
    killall
    acpi
    inkscape
    stow
    firefox
    sbcl
    clisp
    feh
    ctags
    man-pages
    polymc
    man-pages-posix
    mutt
    unzip
    arandr
    htop
    redshift
    tree
    zoxide
    libnotify
    pass
    ripgrep
    julia-bin
    vlc
    kdenlive
    tdesktop
    (pkgs.tor-browser-bundle-bin.override {
          mediaSupport = true;
          pulseaudioSupport = true;
    })
    flameshot

    libnotify

    unifont
    fantasque-sans-mono
    noto-fonts-cjk
    amiri
  ];

  programs.home-manager.enable = true;

  fonts.fontconfig.enable = true;

  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # services.dunst = {
  #   enable = false;
  #   settings = {
  #     global = {
  #       follow = "mouse";
  #       enable_posix_regex = true;
  #       height = 100;
  #       width = 300;
  #       notification_limit = 0;
  #       origin = "top-right";
  #       transparency = 20;
  #       font = "Fantasque Sans Mono 9";
  #       format = "%a - <b>%s</b>\n%b";

  #       mouse_left = "open_url";
  #       mouse_middle = "close_current";
  #       mouse_right = "context";
  #     };
  #   };
  # };

  programs.emacs.enable = true;

  programs.git = {
    enable = true;
    userName = "Gustek";
    userEmail = "gustek@riseup.net";
    aliases = {
      c = "commit";
      b = "branch";
      d = "diff";
      l = "log";
      ps = "push";
      pl = "pull";
      pushall = "'!git remote | xargs -L1 git push --all'";
    };
    signing.signByDefault = true;
    signing.key = "2FDC6432099B36D9";
    extraConfig = {
      pull.rebase = true;
      init.defaultBranch = "master";
    };
  };

  programs.zsh = {
    enable = true;
    shellAliases = {
      ll = "ls -l";
      emacs = "emacs -nw";
      hmb = "home-manager build switch";
      nrs = "doas nixos-rebuild switch -I nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs -I nixos-config=/etc/nixos/configuration.nix -I home-manager=/nix/var/nix/profiles/per-user/root/channels/home-manager";
    };
    initExtra = ''
    function term_size {
             SIZE=''${1:-15}
             FONT=''${2:-FantasqueSansMono}

             printf '\33]50;%s%d\007' "xft:''${FONT}:pixelsize=" "''${SIZE}"
    }
    '';
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
    sessionVariables = {
      DIRENV_ALLOW_NIX = 1;
    };
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "per-directory-history" "zoxide" ];
      theme = "nicoulaj";
      extraConfig = ''
      zstyle  ':omz:update' frequency 7
      '';
    };
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        size = 9.0;
      };
      colors = {
        # Shamelessly taken from https://github.com/eendroroy/alacritty-theme/blob/master/themes/solarized_light.yaml
        primary = {
          background = "0xfdf6e3";
          foreground = "0x586e75";
        };
        normal = {
          black   = "0x073642";
          red     = "0xdc322f";
          green   = "0x859900";
          yellow  = "0xb58900";
          blue    = "0x268bd2";
          magenta = "0xd33682";
          cyan    = "0x2aa198";
          white   = "0xeee8d5";
        };
        bright = {
          black   = "0x002b36";
          red     = "0xcb4b16";
          green   = "0x586e75";
          yellow  = "0x657b83";
          blue    = "0x839496";
          magenta = "0x6c71c4";
          cyan    = "0x93a1a1";
          white   = "0xfdf6e3";
        };
      };
      bell = {
        animation = "EaseOutSine";
        color = "0xfdf6e3";
      };
      cursor = {
        style.shape = "Beam";
      };
      mouse.hide_when_typing = false;
      shell.program = "zsh";
    };
  };
}
