{ config, lib, pkgs, ... }:

{
  imports = [
    ./bluetooth.nix
  ];

  options.mySystem.services.drivers.bluetooth = {
    enable = lib.mkEnableOption "蓝牙驱动支持";
    gui = lib.mkEnableOption "图形管理工具" // { default = true; };
  };
}
