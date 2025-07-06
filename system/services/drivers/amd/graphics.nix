{ config, lib, pkgs, ... }:

{
  # AMD 图形加速实现
  config = lib.mkMerge [
    # OpenGL 支持
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.graphics.opengl) {
      hardware.opengl.extraPackages = with pkgs; [
        mesa.drivers
        libGL
      ];
      
      hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [
        mesa.drivers
        libGL
      ];
    })
    
    # Vulkan 支持
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.graphics.vulkan) {
      hardware.opengl.extraPackages = with pkgs; [
        amdvlk        # AMD 官方 Vulkan 驱动
        vulkan-loader
        vulkan-validation-layers
      ];
      
      hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [
        amdvlk
        vulkan-loader
      ];
      
      environment.variables = {
        VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";
      };
    })
    
    # OpenCL 支持
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.graphics.opencl) {
      hardware.opengl.extraPackages = with pkgs; [
        rocm-opencl-icd
        rocm-opencl-runtime
        clinfo  # OpenCL 信息工具
      ];
      
      environment.systemPackages = with pkgs; [
        opencl-headers
        ocl-icd
      ];
    })
    
    # ROCm 计算平台
    (lib.mkIf (config.mySystem.services.drivers.amd.enable && config.mySystem.services.drivers.amd.graphics.rocm) {
      hardware.opengl.extraPackages = with pkgs; [
        rocm-device-libs
        rocm-runtime
        rocm-thunk
        rocm-smi
      ];
      
      environment.systemPackages = with pkgs; [
        rocm-smi          # ROCm 系统管理
        rocminfo          # ROCm 信息工具
        hip               # HIP 运行时
      ];
      
      # ROCm 设备权限
      services.udev.extraRules = ''
        SUBSYSTEM=="kfd", KERNEL=="kfd", TAG+="uaccess", GROUP="video"
        SUBSYSTEM=="drm", KERNEL=="card*", TAG+="uaccess", GROUP="video"
      '';
    })
  ];
}
