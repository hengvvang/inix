{ config, lib, pkgs, ... }:

{
  # 音频驱动模块的选项定义
  options.mySystem.services.drivers.audio = {
    enable = lib.mkEnableOption "音频驱动基础支持";
    
    # === 音频服务器选项 ===
    server = {
      pipewire = lib.mkEnableOption "PipeWire 音频服务器" // { default = true; };
      pulseaudio = lib.mkEnableOption "PulseAudio 音频服务器";
      jack = lib.mkEnableOption "JACK 专业音频服务器";
    };
     # === ALSA 音频系统选项 ===
    alsa = {
      enable = lib.mkEnableOption "ALSA 音频系统支持" // { default = true; };
    };
 
    # === 实时音频选项 ===
    realtime = {
      enable = lib.mkEnableOption "实时音频支持 (RTKit)";
      lowLatency = lib.mkEnableOption "低延迟音频配置";
      priority = lib.mkOption {
        type = lib.types.int;
        default = 95;
        description = "实时音频优先级";
      };
    };
    
    # === 音频工具选项 ===
    tools = {
      control = lib.mkEnableOption "音频控制工具 (pavucontrol, alsamixer 等)";
      codecs = lib.mkEnableOption "额外音频编解码器";
    };
    

    imports = [
      # === 模块化导入：每个功能独立文件 ===
      ./server.nix        # 音频服务器配置
      ./realtime.nix      # 实时音频配置
    ];
  };
}