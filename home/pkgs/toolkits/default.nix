{ config, lib, pkgs, ... }:

{
  options.myHome.pkgs.toolkits = {
    enable = lib.mkEnableOption "家庭工具包模块";
    
    # 🌒 峨眉月 - 基础家庭工具
    waxingCrescent = {
      enable = lib.mkEnableOption "峨眉月 - 基础家庭工具";
    };
    
    # 🌓 上弦月 - 开发和终端工具
    firstQuarter = {
      enable = lib.mkEnableOption "上弦月 - 开发和终端工具";
    };
    
    # 🌔 盈凸月 - 高级工具套件
    waxingGibbous = {
      enable = lib.mkEnableOption "盈凸月 - 高级工具套件";
    };
    
    # 🌕 满月 - 完整工具生态
    fullMoon = {
      enable = lib.mkEnableOption "满月 - 完整工具生态";
    };
  };

  imports = [
    ./waxing-crescent.nix
    ./first-quarter.nix
    ./waxing-gibbous.nix
    ./full-moon.nix
  ];
}
