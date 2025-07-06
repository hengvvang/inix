{ config, lib, pkgs, ... }:

{
  # 蓝牙音频支持实现
  config = lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.audio.enable) {
    # PipeWire 蓝牙支持
    services.pipewire = {
      enable = true;
      bluetooth.enable = true;
      bluetooth.hsphfpd.enable = lib.mkIf config.mySystem.services.drivers.bluetooth.audio.hsp true;
    };
    
    # 蓝牙音频包
    environment.systemPackages = with pkgs; [
      pulseaudio-ctl    # 音频控制
      pavucontrol       # 音频设置
    ];
    
    # 蓝牙音频配置
    hardware.bluetooth.settings = {
      General = {
        # A2DP 高质量音频
        Enable = lib.mkIf config.mySystem.services.drivers.bluetooth.audio.a2dp "Source,Sink,Media";
      };
    };
  };
}
