{ config, lib, pkgs, ... }:

{
  # Intel 图形加速实现
  config = lib.mkMerge [
    # OpenGL 支持
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.graphics.opengl) {
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
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.graphics.vulkan) {
      hardware.opengl.extraPackages = with pkgs; [
        vulkan-loader
        vulkan-validation-layers
        # Intel Vulkan 驱动 (ANV)
      ];
      
      hardware.opengl.extraPackages32 = with pkgs.pkgsi686Linux; [
        vulkan-loader
      ];
      
      environment.variables = {
        VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/intel_icd.x86_64.json";
      };
    })
    
    # Intel 计算支持 (OpenCL)
    (lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.graphics.compute) {
      hardware.opengl.extraPackages = with pkgs; [
        intel-compute-runtime
        clinfo
      ];
      
      environment.systemPackages = with pkgs; [
        opencl-headers
        ocl-icd
        clinfo
      ];
      
      # Intel OpenCL 设备权限
      services.udev.extraRules = ''
        SUBSYSTEM=="drm", KERNEL=="card*", TAG+="uaccess", GROUP="video"
        SUBSYSTEM=="drm", KERNEL=="renderD*", TAG+="uaccess", GROUP="video"
      '';
    })
  ];
}
