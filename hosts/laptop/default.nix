{ config, lib, pkgs, inputs, outputs, users, hosts, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    outputs.system  # 通过 outputs 导入系统模块     ../../system
  ];

  # Bootloader配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ users.user1 users.user2 ];
  };

  # 启用 fish shell 程序
  programs.fish.enable = true;
  # 用户配置
  users.users.${users.user1} = {
    isNormalUser = true;
    description = users.user1;
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  users.users.${users.user2} = {
    isNormalUser = true;
    description = users.user2;
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
}
