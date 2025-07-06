{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.sound.enable {
    # PipeWire 音频服务配置
    services.pipewire = {
      enable = true;
      
      # 音频服务替换
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      
      # 低延迟配置
      extraConfig.pipewire."92-low-latency" = {
        context.properties = {
          default.clock.rate = 48000;
          default.clock.quantum = 32;
          default.clock.min-quantum = 32;
          default.clock.max-quantum = 32;
        };
      };
    };

    # 音频相关工具
    environment.systemPackages = with pkgs; [
      pipewire
      wireplumber
      pavucontrol  # PulseAudio 音量控制
      pulsemixer   # 命令行音频控制
      alsa-utils   # ALSA 工具
      playerctl    # 媒体播放器控制
    ];

    # 实时音频支持
    security.rtkit.enable = true;
    
    # 用户组配置
    users.users.hengvvang.extraGroups = [ "audio" "pipewire" ];

    # 音频设备权限
    hardware.pulseaudio.enable = false; # 确保 PulseAudio 被禁用

    # 系统级音频配置
    sound.enable = true;
    hardware.pulseaudio.enable = lib.mkForce false;

    # WirePlumber 配置
    services.pipewire.wireplumber.enable = true;
  };
}
