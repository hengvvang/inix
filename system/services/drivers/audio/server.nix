{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # PipeWire 音频服务器
    (lib.mkIf (config.mySystem.services.drivers.audio.enable && config.mySystem.services.drivers.audio.server.pipewire) {
      # 禁用冲突的音频服务
      services.pulseaudio.enable = false;
      
      # 启用 PipeWire
      services.pipewire = {
        enable = true;
        alsa.enable = config.mySystem.services.drivers.audio.alsa.enable;
        alsa.support32Bit = config.mySystem.services.drivers.audio.alsa.support32Bit;
        pulse.enable = true;  # PulseAudio 兼容性
        jack.enable = config.mySystem.services.drivers.audio.server.jack;
        
        # 低延迟配置
        extraConfig.pipewire."92-low-latency" = lib.mkIf config.mySystem.services.drivers.audio.realtime.lowLatency {
          "context.properties" = {
            "default.clock.rate" = 48000;
            "default.clock.quantum" = 32;
            "default.clock.min-quantum" = 32;
            "default.clock.max-quantum" = 32;
          };
        };
      };
    })

    # PulseAudio 音频服务器 (传统)
    (lib.mkIf (config.mySystem.services.drivers.audio.enable && config.mySystem.services.drivers.audio.server.pulseaudio) {
      services.pulseaudio = {
        enable = true;
        support32Bit = config.mySystem.services.drivers.audio.alsa.support32Bit;
        package = pkgs.pulseaudioFull;
      };
    })

    # JACK 专业音频服务器
    (lib.mkIf (config.mySystem.services.drivers.audio.enable && config.mySystem.services.drivers.audio.server.jack) {
      services.jack = {
        jackd.enable = true;
        alsa.enable = config.mySystem.services.drivers.audio.alsa.enable;
      };
      
      # JACK 相关工具
      environment.systemPackages = with pkgs; [
        qjackctl
        jack2
        jack_capture
      ];
    })
  ];
}
