{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.bluetooth;
in
{
  # 蓝牙音频支持实现
  config = lib.mkIf (cfg.enable && cfg.audio.enable) {
    # PipeWire 蓝牙支持
    services.pipewire = {
      enable = true;
      wireplumber.enable = true;
    };
    
    # 蓝牙音频工具
    environment.systemPackages = with pkgs; [
      pulseaudio-ctl    # 音频控制
      pavucontrol       # 音频设置GUI
    ];
    
    # A2DP 高质量音频配置
    hardware.bluetooth.settings = lib.mkIf cfg.audio.a2dp {
      General = {
        Enable = lib.mkDefault "Source,Sink,Media";
      };
    };
  };
}
