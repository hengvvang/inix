{ config, lib, pkgs, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ./disk.nix
    outputs.system  # 通过 outputs 导入系统模块
  ];

  # Bootloader配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ userMapping.user1 userMapping.user2 ];
  };

  # 启用 fish shell 程序
  programs.fish.enable = true;

  # 用户配置 - 工作环境限制权限
  users.users.${userMapping.user1} = {
    isNormalUser = true;
    description = userMapping.user1;
    extraGroups = [ "networkmanager" "wheel" ];  # 工作环境移除 docker 组
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  users.users.${userMapping.user2} = {
    isNormalUser = true;
    description = userMapping.user2;
    extraGroups = [ "networkmanager" "wheel" ];  # 工作环境移除 docker 组
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };
}
