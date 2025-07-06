{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.hardware.enable && config.mySystem.services.hardware.sound.enable) {
    # 禁用传统音频服务
    services.pulseaudio.enable = false;
    
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
      
      # WirePlumber 配置
      wireplumber.enable = true;
    };

    # 音频相关工具
    environment.systemPackages = with pkgs; [
      pipewire
      wireplumber
      pavucontrol  # PulseAudio 音量控制
      pulsemixer   # 命令行音频控制
      alsa-utils   # ALSA 工具
      playerctl    # 媒体播放器控制
      qpwgraph     # PipeWire 图形界面
      helvum       # PipeWire 补丁面板
    ];

    # 实时音频支持
    security.rtkit.enable = true;
    
    # 音频优化
    security.pam.loginLimits = [
      { domain = "@audio"; item = "memlock"; type = "-"; value = "unlimited"; }
      { domain = "@audio"; item = "rtprio"; type = "-"; value = "99"; }
      { domain = "@audio"; item = "nofile"; type = "soft"; value = "99999"; }
      { domain = "@audio"; item = "nofile"; type = "hard"; value = "99999"; }
    ];
  };
}
