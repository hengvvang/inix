{ config, lib, pkgs, ... }:

{
  # AMD 显卡驱动模块的完整选项定义
  options.mySystem.services.drivers.amd = {
    enable = lib.mkEnableOption "AMD 显卡驱动基础支持";
    
    # === 核心驱动选项 ===
    driver = {
      type = lib.mkOption {
        type = lib.types.enum [ "amdgpu" "radeon" ];
        default = "amdgpu";
        description = "AMD 驱动类型";
      };
      modesetting = lib.mkEnableOption "AMD modesetting 支持" // { default = true; };
    };
    
    # === 图形加速选项 ===
    graphics = {
      opengl = lib.mkEnableOption "OpenGL 硬件加速" // { default = true; };
      vulkan = lib.mkEnableOption "Vulkan API 支持" // { default = true; };
      opencl = lib.mkEnableOption "OpenCL 计算支持";
      rocm = lib.mkEnableOption "ROCm 计算平台支持";
    };
    
    # === 编解码器选项 ===
    codecs = {
      vaapi = lib.mkEnableOption "VA-API 视频加速";
      vdpau = lib.mkEnableOption "VDPAU 视频加速";
      amf = lib.mkEnableOption "AMD 媒体框架支持";
    };
    
    # === 性能调优选项 ===
    performance = {
      powerProfile = lib.mkOption {
        type = lib.types.enum [ "default" "high" "low" "auto" ];
        default = "default";
        description = "AMD 功耗配置";
      };
      fanControl = lib.mkEnableOption "风扇控制支持";
      overclocking = lib.mkEnableOption "超频支持";
    };
  };

  imports = [
    ./core.nix         # 核心驱动
    ./graphics.nix     # 图形加速
    ./codecs.nix       # 编解码器
    ./performance.nix  # 性能调优
  ];
}
