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
    trusted-users = [ users.user1 users.user2 ];
    # 并行构建限制 - 平衡性能与内存使用
    # max-jobs = 12;  # 32核心的37.5%，提升构建速度
    # cores = 2;      # 每个构建任务使用2个核心
    # 大型包构建优化
    # builders-use-substitutes = true;
    # 内存限制保护
    # max-silent-time = 7200;  # 2小时无输出超时
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
