{ config, lib, pkgs, ... }:

{
  # Intel 显卡驱动模块的完整选项定义
  options.mySystem.services.drivers.intel = {
    enable = lib.mkEnableOption "Intel 显卡驱动基础支持";
    
    # === 核心驱动选项 ===
    driver = {
      type = lib.mkOption {
        type = lib.types.enum [ "modesetting" "intel" ];
        default = "modesetting";
        description = "Intel 驱动类型";
      };
      acceleration = lib.mkEnableOption "Intel 硬件加速" // { default = true; };
    };
    
    # === 图形加速选项 ===
    graphics = {
      opengl = lib.mkEnableOption "OpenGL 硬件加速" // { default = true; };
      vulkan = lib.mkEnableOption "Vulkan API 支持";
      compute = lib.mkEnableOption "Intel 计算支持 (OpenCL)";
    };
    
    # === 编解码器选项 ===
    codecs = {
      vaapi = lib.mkEnableOption "VA-API 视频加速" // { default = true; };
      quicksync = lib.mkEnableOption "Intel Quick Sync 视频编码";
      hevc = lib.mkEnableOption "HEVC/H.265 编解码支持";
      av1 = lib.mkEnableOption "AV1 编解码支持";
    };
    
    # === 电源管理选项 ===
    power = {
      enable = lib.mkEnableOption "Intel GPU 电源管理" // { default = true; };
      turbo = lib.mkEnableOption "Intel GPU Turbo Boost";
      throttling = lib.mkEnableOption "动态频率调节";
    };
  };

  imports = [
    ./core.nix         # 核心驱动
    ./graphics.nix     # 图形加速
    ./codecs.nix       # 编解码器
    ./power.nix        # 电源管理
  ];
}
