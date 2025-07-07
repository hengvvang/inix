{ config, lib, pkgs, ... }:

{
  # 蓝牙驱动模块 - 极简版
  options.mySystem.services.drivers.bluetooth = {
    enable = lib.mkEnableOption "蓝牙驱动支持";
    gui = lib.mkEnableOption "图形管理工具" // { default = true; };
  };

  imports = [
    ./bluetooth.nix
  ];

}
