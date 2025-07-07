{ config, lib, pkgs, ... }:

{
  # 音频驱动模块 - 极简版
  options.mySystem.services.drivers.audio = {
    enable = lib.mkEnableOption "音频驱动支持";
    controls = lib.mkEnableOption "音频控制工具" // { default = true; };
  };

  imports = [
    ./audio.nix
  ];

}