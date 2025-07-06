{ config, lib, pkgs, ... }:

{
  # 打印驱动模块的完整选项定义
  options.mySystem.services.drivers.printing = {
    enable = lib.mkEnableOption "打印驱动基础支持";
    
    # === 核心服务选项 ===
    service = {
      cups = lib.mkEnableOption "CUPS 打印服务" // { default = true; };
      discovery = lib.mkEnableOption "网络打印机发现" // { default = true; };
      sharing = lib.mkEnableOption "打印机共享";
    };
    
    # === 打印机驱动选项 ===
    drivers = {
      hp = lib.mkEnableOption "HP 打印机驱动";
      canon = lib.mkEnableOption "Canon 打印机驱动";
      epson = lib.mkEnableOption "Epson 打印机驱动";
      brother = lib.mkEnableOption "Brother 打印机驱动";
      generic = lib.mkEnableOption "通用打印驱动" // { default = true; };
    };
    
    # === 扫描功能选项 ===
    scanning = {
      enable = lib.mkEnableOption "扫描功能支持";
      sane = lib.mkEnableOption "SANE 扫描后端" // { default = true; };
      network = lib.mkEnableOption "网络扫描支持";
    };
    
    # === 工具选项 ===
    tools = {
      gui = lib.mkEnableOption "图形管理工具";
      cli = lib.mkEnableOption "命令行工具";
      maintenance = lib.mkEnableOption "维护工具";
    };
  };

  imports = [
    ./core.nix         # 核心打印服务
    ./drivers.nix      # 打印机驱动
    ./scanning.nix     # 扫描功能
    ./tools.nix        # 管理工具
  ];
}
