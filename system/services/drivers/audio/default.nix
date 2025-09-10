{ config, lib, pkgs, ... }:

{
  imports = [
    ./audio.nix
  ];
  # 音频驱动模块 - 极简版
  options.mySystem.services.drivers.audio = {
    enable = lib.mkEnableOption "音频驱动支持";
    toolkits = lib.mkEnableOption "音频控制工具" // { default = true; };
  };
}
