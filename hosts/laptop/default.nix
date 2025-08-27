{ config, lib, pkgs, inputs, outputs, ... }:

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
  # 启用zram来缓解内存压力
  # zramSwap = {
  #   enable = true;
  #   memoryPercent = 50;  # 使用50%的RAM作为压缩交换空间
  # };

  # 系统性能优化
  # boot.kernel.sysctl = {
  #   "vm.swappiness" = 60;        # 适度使用swap
  #   "vm.vfs_cache_pressure" = 50; # 减少缓存压力
  # };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = [ "hengvvang" "zlritsu" ];
    # 并行构建限制 - 平衡性能与内存使用
    # max-jobs = 12;  # 32核心的37.5%，提升构建速度
    # cores = 2;      # 每个构建任务使用2个核心
    # 大型包构建优化
    # builders-use-substitutes = true;
    # 内存限制保护
    # max-silent-time = 7200;  # 2小时无输出超时
  };

  # 用户配置
  users.users.hengvvang = {
    isNormalUser = true;
    description = "hengvvang";
    extraGroups = [ "networkmanager" "wheel" "docker" "flatpak" "dialout" "plugdev" "input" "mpd" ];
    packages = with pkgs; [
      # 用户特定的包可以在这里定义
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
  programs.fish.enable = true;
}
