{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ../../system
  ];

  # Bootloader配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Nix配置
  nixpkgs.config.allowUnfree = true;
  
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "hengvvang" "zlritsu" ];
  };

  # 启用 fish shell 程序
  programs.fish.enable = true;

  # 用户配置
  users.users.hengvvang = {
    isNormalUser = true;
    description = "hengvvang";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
  
  users.users.zlritsu = {
    isNormalUser = true;
    description = "zlritsu";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  # 系统版本
  system.stateVersion = "25.05";
}
