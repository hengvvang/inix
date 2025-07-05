{ config, lib, pkgs, ... }:

{
  options.mySystem.hardware = lib.mkEnableOption "硬件配置";

  imports = [
    ./hardware.nix
  ];
}
