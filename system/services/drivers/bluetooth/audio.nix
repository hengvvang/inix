{ config, lib, pkgs, ... }:

{
  # 蓝牙音频支持实现
  config = lib.mkIf (config.mySystem.services.drivers.bluetooth.enable && config.mySystem.services.drivers.bluetooth.audio.enable) {
    # PipeWire 蓝牙支持
    services.pipewire = {
      enable = true;
      # 在新版本中，bluetooth 支持通过 wireplumber 配置
      wireplumber.enable = true;
      # bluetooth.enable = true;  # 此选项在新版本中不存在
      # bluetooth.hsphfpd.enable = lib.mkIf config.mySystem.services.drivers.bluetooth.audio.hsp true;
    };
    
    # 蓝牙音频包
    environment.systemPackages = with pkgs; [
      pulseaudio-ctl    # 音频控制
      pavucontrol       # 音频设置
    ];
    
    # 蓝牙音频配置
    hardware.bluetooth.settings = lib.mkIf config.mySystem.services.drivers.bluetooth.audio.a2dp {
      General = {
        # A2DP 高质量音频 - 使用 mkDefault 避免冲突
        Enable = lib.mkDefault "Source,Sink,Media";
      };
    };
  };
}
