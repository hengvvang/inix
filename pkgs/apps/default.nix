{ config, lib, pkgs, ... }:

{
  options.myPkgs.apps = {
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

  imports = [
    ./waning-crescent.nix
    ./last-quarter.nix
    ./waning-gibbous.nix
    ./new-moon.nix
  ];
}
