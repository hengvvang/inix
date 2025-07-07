{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.audio;
in
{

  config = lib.mkIf cfg.enable {
    # 现代音频系统：PipeWire（替代 PulseAudio）
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;  # PulseAudio 兼容性
      wireplumber.enable = true;
    };

    # 音频设备权限
    users.groups.audio = {};
    
    # 音频控制工具
    environment.systemPackages = with pkgs; [
      alsa-utils        # ALSA 工具集
    ] ++ lib.optionals cfg.controls [
      pavucontrol       # PipeWire/PulseAudio 图形控制面板
      pulsemixer        # 终端音频混音器
      helvum            # PipeWire 图形连接器
    ];

    # 音频设备 udev 规则
    services.udev.extraRules = ''
      # 音频设备权限
      SUBSYSTEM=="sound", GROUP="audio", MODE="0664"
      KERNEL=="controlC[0-9]*", GROUP="audio", MODE="0664"
    '';
  };
}