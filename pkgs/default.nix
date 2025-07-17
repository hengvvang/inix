# 统一包管理模块

{ config, lib, pkgs, ... }:

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
  };

  imports = [
    ./toolkits
    ./apps
  ];
}
