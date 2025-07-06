{ config, lib, pkgs, ... }:

{
  options.mySystem.hardware.enable = lib.mkEnableOption "硬件配置";

  imports = [
    ./hardware.nix
  ];
}
