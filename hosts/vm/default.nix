{ config, lib, pkgs, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    outputs.system
    ./hardware.nix
    ./system.nix
  ];

  # Bootloader.
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = true;

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "cn";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  system.stateVersion = "25.05"; # Did you read the comment?
  nix = {
    package = pkgs.nix;
    # trusted-users = [ hengvvang zlritsu ];
    settings.experimental-features = [ "nix-command" "flakes" ];
  };

  nixpkgs.config.allowUnfree = true;
  programs.fish.enable = true;
  programs.firefox.enable = true;
  environment.systemPackages = with pkgs; [
    vim
    git
    vscode
  ];

  users.users.hengvvang = {
    isNormalUser = true;
    description = "hengvvang";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
    #  thunderbird
    ];
    shell = pkgs.fish;
  };

  users.users.zlritsu = {
    isNormalUser = true;
    description = "zlritsu";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
}
