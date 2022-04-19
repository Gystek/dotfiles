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
  };

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

  users.users.gustek = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "audio" "sound" "video" "docker" ];
  };

  security.sudo.enable = false;
  security.doas = {
    enable = true;
    extraRules = [
      { users = [ "gustek" ]; persist = true; keepEnv = true; }
    ];
  };

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "home-manager=/nix/var/nix/profiles/per-user/root/channels/home-manager"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    w3m
    bash
    xorg.setxkbmap
    xorg.xmodmap
    pavucontrol
  ];

  programs = {
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
    slock.enable = true;
  };

  system.stateVersion = "21.05";
}
