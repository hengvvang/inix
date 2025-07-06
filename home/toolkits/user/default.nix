{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.user = {
    utilities.enable = lib.mkEnableOption "用户实用工具";
  };

  imports = [
    ./utilities.nix
  ];
}