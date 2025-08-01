{ config, lib, pkgs, inputs, outputs, users, hosts, ... }:

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
    trusted-users = [ users.user1 users.user2 ];
  };

  # 启用 fish shell 程序 (macOS 方式)
  programs.fish.enable = true;
  
  # macOS 用户配置
  users.users.${users.user1} = {
    name = users.user1;
    home = "/Users/${users.user1}";
    shell = pkgs.fish;
  };

  users.users.${users.user2} = {
    name = users.user2;
    home = "/Users/${users.user2}";
    shell = pkgs.fish;
  };
}
