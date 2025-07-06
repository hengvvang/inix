{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.nvidia.enable {
    # NVIDIA 核心驱动配置
    services.xserver.videoDrivers = [ "nvidia" ];
    
    # 基础硬件配置
    hardware.nvidia = {
      # 基础驱动设置
      modesetting.enable = config.mySystem.services.drivers.nvidia.driver.modesetting;
      open = config.mySystem.services.drivers.nvidia.driver.openSource;
      
      # 基础包
      package = if config.mySystem.services.drivers.nvidia.driver.openSource 
                then config.boot.kernelPackages.nvidiaPackages.open
                else config.boot.kernelPackages.nvidiaPackages.stable;
    };

    # 启用必要的内核模块
    boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
    
    # 基础环境变量
    environment.variables = {
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
