{ config, lib, pkgs, ... }:

{
  options.mySystem.pkgs = {
    enable = lib.mkEnableOption "系统包管理模块支持";
    apps.enable = lib.mkEnableOption "应用程序包管理支持";
    toolkits.enable = lib.mkEnableOption "工具包管理支持";
  };

  imports = [
    ./apps.nix
    ./toolkits.nix
  ];
}
