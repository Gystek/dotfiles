{ config, pkgs, lib, ... }:

{
  imports =
    [
      /etc/nixos/hardware-configuration.nix
      <home-manager/nixos>
    ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/Brussels";

  networking = {
    hostName = "caiman";
    useDHCP = false;
    interfaces = {
      enp1s0.useDHCP = true;
      wlp2s0.useDHCP = true;
    };
    networkmanager.enable = true;
    nameservers = [ "80.67.169.12" "80.67.169.40" ];
  };

  services.nscd.enable = true;
  system.nssDatabases.hosts = [ "mymachines" "mdns_minimal" "[NOTFOUND=return]" "mdns" ];

  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  services.xserver = {
    enable = true;
    layout = "us";
    autorun = false;
    libinput.enable = true;
    windowManager.stumpwm.enable = true;
    desktopManager.xterm.enable = false;
    displayManager.startx.enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
  };
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "steam-original"
    "steam"
    "steam-runtime"
  ];
  programs.steam.enable = true;	

  users.users.gustek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "sound" "video" "docker" ];
    packages = with pkgs; [ steam ];
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      { users = [ "gustek" ]; persist = true; keepEnv = true; }
    ];
  };

  nix = {
    nixPath = [
      "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs"
      "nixos-config=/etc/nixos/configuration.nix"
      "home-manager=/nix/var/nix/profiles/per-user/root/channels/home-manager"
      "/nix/var/nix/profiles/per-user/root/channels"
    ];
    extraOptions = ''
      keep-outputs = true     
      keep-derivations = true
    '';
  };

  environment.systemPackages = with pkgs; [
    vim
    wget
    w3m
    bash
    xorg.setxkbmap
    xorg.xmodmap
    pavucontrol
  ];

  virtualisation.docker.enable = true;

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    slock.enable = true;
  };

  system.stateVersion = "21.05";
}
