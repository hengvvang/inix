{ config, lib, pkgs, ... }:

{
  imports = [
    ./printing.nix
    ./scanning.nix    # 扫描功能模块
  ];

  # 打印和扫描驱动配置选项
  options.mySystem.services.drivers.printing = {
    enable = lib.mkEnableOption "打印和扫描功能支持";

    # 核心服务选项
    service = {
      discovery = lib.mkEnableOption "网络打印机自动发现" // { default = true; };
      sharing = lib.mkEnableOption "打印机网络共享" // { default = false; };
    };

    # 打印机品牌驱动
    drivers = {
      hp = lib.mkEnableOption "HP 打印机驱动" // { default = false; };
      canon = lib.mkEnableOption "Canon 打印机驱动" // { default = false; };
      epson = lib.mkEnableOption "Epson 打印机驱动" // { default = false; };
      brother = lib.mkEnableOption "Brother 打印机驱动" // { default = false; };
    };

    # 扫描功能
    scanning = {
      enable = lib.mkEnableOption "扫描功能支持" // { default = true; };
      network = lib.mkEnableOption "网络扫描支持" // { default = false; };
    };

    # 管理工具
    tools = {
      gui = lib.mkEnableOption "图形管理工具" // { default = true; };
      maintenance = lib.mkEnableOption "打印机维护工具" // { default = false; };
    };
  };
}
