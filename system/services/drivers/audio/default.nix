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
    
    # === ALSA 配置选项 ===
    alsa = {
      enable = lib.mkEnableOption "ALSA 声卡支持" // { default = true; };
      support32Bit = lib.mkEnableOption "32位应用音频支持" // { default = true; };
      dmix = lib.mkEnableOption "ALSA 多路复用支持";
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
      control = lib.mkEnableOption "音频控制工具 (pavucontrol)";
      effects = lib.mkEnableOption "音频效果处理工具";
      bluetooth = lib.mkEnableOption "蓝牙音频支持";
      codec = lib.mkEnableOption "高级音频编解码器";
    };
    
    # === 专业音频选项 ===
    professional = {
      enable = lib.mkEnableOption "专业音频工作站配置";
      vst = lib.mkEnableOption "VST 插件支持";
      ladspa = lib.mkEnableOption "LADSPA 插件支持";
      recording = lib.mkEnableOption "录音工作站配置";
    };
  };

  imports = [
    # === 模块化导入：每个功能独立文件 ===
    ./server.nix        # 音频服务器配置
    ./alsa.nix          # ALSA 配置
    ./realtime.nix      # 实时音频配置
    ./tools.nix         # 音频工具
    ./professional.nix  # 专业音频配置
  ];
}
