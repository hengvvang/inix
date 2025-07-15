{ config, lib, pkgs, ... }:

{
  options.mySystem.pkgs.toolkits = {
    enable = lib.mkEnableOption "工具包模块";
    
    # 🌒 峨眉月 - 基础终端增强
    waxingCrescent = {
      enable = lib.mkEnableOption "峨眉月 - 基础终端增强";
    };
    
    # 🌓 上弦月 - 高级终端和基础开发
    firstQuarter = {
      enable = lib.mkEnableOption "上弦月 - 高级终端和基础开发";
    };
    
    # 🌔 盈凸月 - 完整开发环境
    waxingGibbous = {
      enable = lib.mkEnableOption "盈凸月 - 完整开发环境";
    };
    
    # 🌕 满月 - 桌面办公套件
    fullMoon = {
      enable = lib.mkEnableOption "满月 - 桌面办公套件";
    };
  };

  imports = [
    ./waxing-crescent.nix
    ./first-quarter.nix
    ./waxing-gibbous.nix
    ./full-moon.nix
  ];
}
