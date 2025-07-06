{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.audio.enable {
    # 音频配置 - 从 system/hardware/hardware.nix 迁移
    # 禁用传统的 PulseAudio
    services.pulseaudio.enable = false;
    
    # 启用实时工具包（音频低延迟）
    security.rtkit.enable = true;
    
    # 启用 PipeWire（现代音频服务器）
    services.pipewire = {
      enable = true;
      alsa.enable = true;          # ALSA 兼容性
      alsa.support32Bit = true;    # 32位应用支持
      pulse.enable = true;         # PulseAudio 兼容性
    };

    # 音频相关包
    environment.systemPackages = with pkgs; [
      pavucontrol   # PulseAudio 音量控制
      pulseaudio    # 命令行工具
    ];
  };
}
