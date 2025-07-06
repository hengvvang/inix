{ config, lib, pkgs, ... }:

{
  # Intel 编解码器实现
  config = lib.mkMerge [
    # VA-API 视频加速
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.codecs.vaapi) {
      hardware.opengl.extraPackages = with pkgs; [
        intel-media-driver  # iHD 驱动 (新一代)
        vaapiIntel         # i965 驱动 (传统)
        libva
        libva-utils
      ];
      
      environment.systemPackages = with pkgs; [
        vainfo
        libva-utils
      ];
      
      environment.variables = {
        # 优先使用新的 iHD 驱动
        LIBVA_DRIVER_NAME = "iHD";
      };
    })
    
    # Intel Quick Sync 视频编码
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.codecs.quicksync) {
      hardware.opengl.extraPackages = with pkgs; [
        intel-media-driver
        intel-media-sdk
      ];
      
      # Quick Sync 需要特定内核参数
      boot.kernelParams = [
        "i915.enable_guc=2"
      ];
    })
    
    # HEVC/H.265 支持
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.codecs.hevc) {
      hardware.opengl.extraPackages = with pkgs; [
        intel-media-driver  # 支持 HEVC 编解码
      ];
      
      environment.variables = {
        # 确保使用支持 HEVC 的驱动
        LIBVA_DRIVER_NAME = "iHD";
      };
    })
    
    # AV1 编解码支持 (较新的 Intel GPU)
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.codecs.av1) {
      hardware.opengl.extraPackages = with pkgs; [
        intel-media-driver  # 最新版本支持 AV1
      ];
      
      # AV1 支持需要较新的 GPU 和驱动
      boot.kernelParams = [
        "i915.enable_guc=3"  # 更高级的 GuC 支持
      ];
    })
    
    # VDPAU 支持 (通过 VA-API 桥接)
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.codecs.vaapi) {
      hardware.opengl.extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
      
      environment.systemPackages = with pkgs; [
        vdpauinfo
      ];
      
      environment.variables = {
        VDPAU_DRIVER = "va_gl";
      };
    })
  ];
}
