{ config, lib, pkgs, inputs, outputs, ... }:

{
  imports = [
    ./hardware.nix
    ./system.nix
    ./disk.nix
    outputs.system
  ];

  # Bootloader配置
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  nixpkgs.config.allowUnfree = true;
  system.stateVersion = "25.05";
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ hengvvang zlritsu ];
  };

  # 用户配置 - 工作环境限制权限
  users.users.hengvvang = {
    isNormalUser = true;
    description = hengvvang;
    extraGroups = [ "networkmanager" "wheel" ];  # 工作环境移除 docker 组
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
    shell = pkgs.fish;
  };

  users.users.zlritsu = {
    isNormalUser = true;
    description = zlritsu;
    extraGroups = [ "networkmanager" "wheel" ];  # 工作环境移除 docker 组
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
    ];
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
  programs.steam = {
      enable = true;
      remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
      dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
      localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
  };
  # 启用 fish shell 程序
  programs.fish.enable = true;
}
