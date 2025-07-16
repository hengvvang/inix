{ config, lib, pkgs, ... }:

{
  options.myHome.pkgs.apps = {
    enable = lib.mkEnableOption "家庭应用程序模块";
    
    # 🌘 残月 - 基础应用核心
    waningCrescent = {
      enable = lib.mkEnableOption "残月 - 基础应用核心" // { default = false; };
    };
    
    # 🌗 下弦月 - 开发和终端应用
    lastQuarter = {
      enable = lib.mkEnableOption "下弦月 - 开发和终端应用" // { default = false; };
    };
    
    # 🌖 亏凸月 - 桌面生产力套件
    waningGibbous = {
      enable = lib.mkEnableOption "亏凸月 - 桌面生产力套件" // { default = false; };
    };
    
    # 🌑 新月 - 完整应用生态
    newMoon = {
      enable = lib.mkEnableOption "新月 - 完整应用生态" // { default = false; };
    };
  };

  imports = [
    ./waning-crescent.nix
    ./last-quarter.nix
    ./waning-gibbous.nix
    ./new-moon.nix
  ];
}
