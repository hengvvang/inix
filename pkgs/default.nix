# 统一包管理模块

{ config, lib, pkgs, ... }:

let
  cfg = config.myPkgs;
in
{
  options.myPkgs = {
    enable = lib.mkEnableOption "统一包管理模块";
    
    target = lib.mkOption {
      type = lib.types.enum [ "system" "home" ];
      default = "home";
      description = ''
        包安装目标:
        - system: 安装到系统级别 (environment.systemPackages)
        - home: 安装到用户级别 (home.packages)
      '';
    };

    toolkits = {
      enable = lib.mkEnableOption "工具包模块";
      
      # 🌒 峨眉月
      waxingCrescent = {
        enable = lib.mkEnableOption "峨眉月 - 基础家庭工具";
      };
      
      # 🌓 上弦月
      firstQuarter = {
        enable = lib.mkEnableOption "上弦月 - 开发和终端工具";
      };
      
      # 🌔 盈凸月
      waxingGibbous = {
        enable = lib.mkEnableOption "盈凸月 - 高级工具套件";
      };
      
      # � 满月
      fullMoon = {
        enable = lib.mkEnableOption "满月 - 完整工具生态";
      };
    };

    apps = {
      enable = lib.mkEnableOption "应用程序模块";
      
      # 🌘 残月
      waningCrescent = {
        enable = lib.mkEnableOption "残月 - 基础应用核心";
      };
      
      # 🌗 下弦月
      lastQuarter = {
        enable = lib.mkEnableOption "下弦月 - 开发和终端应用";
      };
      
      # 🌖 亏凸月
      waningGibbous = {
        enable = lib.mkEnableOption "亏凸月 - 桌面生产力套件";
      };
      
      # 🌑 新月
      newMoon = {
        enable = lib.mkEnableOption "新月 - 完整应用生态";
      };
    };
  };

  imports = [
    ./toolkits
    ./apps
  ];
}
