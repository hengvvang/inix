{ config, lib, pkgs, inputs, outputs, userMapping, hostMapping, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    # outputs.system  # macOS 不需要 NixOS 系统模块
  ];

  # macOS 系统配置
  nixpkgs.config.allowUnfree = true;
  system.stateVersion = 4;  # macOS 使用数字版本

  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ hengvvang zlritsu ];
  };

  # 启用 fish shell 程序 (macOS 方式)
  programs.fish.enable = true;

  # macOS 用户配置
  users.users.hengvvang = {
    name = hengvvang;
    home = "/Users/hengvvang";
    shell = pkgs.fish;
  };

  users.users.zlritsu = {
    name = zlritsu;
    home = "/Users/zlritsu";
    shell = pkgs.fish;
  };
}
