{ config, lib, pkgs, ... }:

{
  # 触摸板驱动模块 - 极简版
  options.mySystem.services.drivers.touchpad = {
    enable = lib.mkEnableOption "触摸板驱动支持";
    gestures = lib.mkEnableOption "手势支持" // { default = false; };
  };

  imports = [
    ./touchpad.nix
  ];

}
