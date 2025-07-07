{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.amd;
in
{
  # AMD 驱动基础实现
  config = lib.mkIf cfg.enable {
    # === 核心驱动配置 ===
    services.xserver.videoDrivers = [ "amdgpu" ];
    
    # 内核模块
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];
    
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
      ] ++ lib.optionals cfg.graphics.vulkan [
        # Vulkan 支持
        amdvlk
        vulkan-loader
        vulkan-validation-layers
      ] ++ lib.optionals cfg.graphics.opencl [
        # OpenCL 计算支持
        rocm-opencl-icd
        rocm-opencl-runtime
      ] ++ lib.optionals cfg.codecs.vaapi [
        # VA-API 视频编解码
        libva
        libva-utils
        mesa.drivers
      ] ++ lib.optionals cfg.codecs.vdpau [
        # VDPAU 视频编解码
        vdpauinfo
        libvdpau-va-gl
      ];
      
      # 32位支持包
      extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.drivers
        libGL
      ] ++ lib.optionals cfg.graphics.vulkan [
        amdvlk
        vulkan-loader
      ];
    };
    
    # === 基础工具包 ===
    environment.systemPackages = with pkgs; [
      # 监控工具
      amdgpu_top
      radeontop
      
      # 信息工具
      glxinfo
      vulkan-tools
    ] ++ lib.optionals cfg.codecs.vaapi [
      vainfo
      libva-utils
    ] ++ lib.optionals cfg.codecs.vdpau [
      vdpauinfo
    ];
    
    # === 环境变量配置 ===
    environment.variables = {
      AMD_VULKAN_ICD = "RADV";
    } // lib.optionalAttrs cfg.codecs.vaapi {
      LIBVA_DRIVER_NAME = "radeonsi";
    };
  };
}

