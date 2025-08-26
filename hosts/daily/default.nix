{ config, lib, pkgs, inputs, outputs, ... }:

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

  environment.systemPackages = [
      pkgs.git
      pkgs.vim
      # inputs.zen-browser.packages.${pkgs.system}.twilight
      # pkgs.google-chrome
      # inputs.zed-editor.packages.${pkgs.system}.default
      # pkgs.zed-editor
      # pkgs.vscode

      # pkgs.nh                    # NixOS/Home Manager 助手
      # pkgs.nix-output-monitor    # 美化 Nix 构建输出 (提供 nom 命令)
      # pkgs.nix-tree             # 查看 Nix store 依赖关系
      # pkgs.nixos-rebuild        # NixOS 系统重建工具
      # pkgs.nvd                  # Nix 版本差异比较工具
  ];
  programs.clash-verge = {
      enable = true;
      package = pkgs.clash-verge-rev;
      tunMode = true;
      # autoStart = true;
      serviceMode = true;
  };
  programs.fish.enable = true;
}
