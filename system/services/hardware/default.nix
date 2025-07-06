{ config, lib, pkgs, ... }:

{
  options.mySystem.services.hardware = {
    printing.enable = lib.mkEnableOption "CUPS 打印服务";
    bluetooth.enable = lib.mkEnableOption "蓝牙服务";
    sound.enable = lib.mkEnableOption "PipeWire 音频服务";
  };

  imports = [
    ./printing
    ./bluetooth
    ./sound
  ];
}
