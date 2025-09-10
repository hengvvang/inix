{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.intel;
in
{
  # Intel 驱动基础实现
  config = lib.mkIf cfg.enable {
    # === 核心驱动配置 ===
    services.xserver.videoDrivers = [ cfg.driver ];
    # 内核模块
    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelModules = [ "i915" ];
    # === 图形硬件支持 ===
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      # 合并所有图形驱动包
      extraPackages = with pkgs; [
        # 基础 OpenGL 驱动
        mesa.drivers
        libGL
        intel-media-driver  # Intel 媒体驱动
      ] ++ lib.optionals cfg.graphics.vulkan [
        # Vulkan 支持
        vulkan-loader
        vulkan-validation-layers
        mesa.drivers  # 包含 ANV Vulkan 驱动
      ] ++ lib.optionals cfg.graphics.compute [
        # OpenCL 计算支持
        intel-compute-runtime
        intel-ocl
      ] ++ lib.optionals cfg.codecs.vaapi [
        # VA-API 视频编解码
        libva
        libva-utils
        intel-vaapi-driver
      ] ++ lib.optionals cfg.codecs.quicksync [
        # Quick Sync 视频编码
        intel-media-sdk
      ];

      # 32位支持包
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.drivers
        libGL
      ] ++ lib.optionals cfg.graphics.vulkan [
        vulkan-loader
        mesa.drivers
      ] ++ lib.optionals cfg.codecs.vaapi [
        libva
        intel-vaapi-driver
      ];
    };

    # === 基础工具包 ===
    environment.systemPackages = with pkgs; [
      # 监控和调试工具
      intel-gpu-tools

      # 图形信息工具
      glxinfo
      vulkan-tools
    ] ++ lib.optionals cfg.codecs.vaapi [
      libva-utils
      vainfo
    ] ++ lib.optionals cfg.graphics.compute [
      clinfo          # OpenCL 信息
    ];

    # === 环境变量配置 ===
    environment.variables = lib.mkMerge [
      # VA-API 配置
      (lib.mkIf cfg.codecs.vaapi {
        LIBVA_DRIVER_NAME = "iHD";  # Intel Hardware Driver
      })

      # OpenCL 配置
      (lib.mkIf cfg.graphics.compute {
        INTEL_OPENCL_ICD = "${pkgs.intel-compute-runtime}/etc/OpenCL/vendors/intel.icd";
      })
    ];

    # === 设备权限配置 ===
    services.udev.extraRules = ''
      # Intel GPU 设备权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="i915", GROUP="video", MODE="0664"
      KERNEL=="renderD[0-9]*", SUBSYSTEM=="drm", DRIVERS=="i915", GROUP="video", MODE="0664"

      # Intel GPU 媒体设备权限
      SUBSYSTEM=="drm", KERNEL=="card*", ATTR{vendor}=="0x8086", GROUP="video", MODE="0664"
    '';

    # 确保用户在 video 组中
    users.groups.video = {};
  };
}
