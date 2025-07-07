{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.user = {
    enable = lib.mkEnableOption "用户工具包支持";
    utilities.enable = lib.mkEnableOption "用户实用工具";
  };

  imports = [
    ./utilities.nix
  ];
}