{ config, lib, pkgs, ... }:

{
  options.mySystem.pkgs.apps = {
    enable = lib.mkEnableOption "应用软件模块";
    
    # � 亏凸月 - 高级生产力工具
    waningGibbous = {
      enable = lib.mkEnableOption "亏凸月 - 高级生产力工具" // { default = false; };
    };
    
    # � 下弦月 - 媒体和创意工具
    lastQuarter = {
      enable = lib.mkEnableOption "下弦月 - 媒体和创意工具" // { default = false; };
    };
    
    # � 残月 - 通讯娱乐套件
    waningCrescent = {
      enable = lib.mkEnableOption "残月 - 通讯娱乐套件" // { default = false; };
    };
    
    # � 新月 - 系统核心基础
    newMoon = {
      enable = lib.mkEnableOption "新月 - 系统核心基础" // { default = false; };
    };
  };

  imports = [
    ./waning-gibbous.nix
    ./last-quarter.nix
    ./waning-crescent.nix
    ./new-moon.nix
  ];
}
