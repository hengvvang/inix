{ config, lib, pkgs, inputs, outputs, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    outputs.system  # 通过 outputs 导入系统模块  即 ../../system
  ];

  # Bootloader配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

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
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  users.users.zlritsu = {
    isNormalUser = true;
    description = "zlritsu";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
}
