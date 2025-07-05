{ config, lib, pkgs, ... }:

{
  options.mySystem.packages = {
    enable = lib.mkEnableOption "系统包配置";
  };

  imports = [
    ./packages.nix
  ];
}
