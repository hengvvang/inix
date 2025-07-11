{ config, lib, pkgs, ... }:

{
  options.mySystem.pkgs = {
    enable = lib.mkEnableOption "系统包管理模块支持";
  };

  imports = [
    ./apps
    ./toolkits
  ];
}
