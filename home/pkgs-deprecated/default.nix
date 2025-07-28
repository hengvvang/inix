{ config, lib, pkgs, ... }:

{
  options.myHome.pkgs = {
    enable = lib.mkEnableOption "Home Manager 包管理模块支持";
  };

  imports = [
    ./toolkits
    ./apps
  ];
}
