{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.enable && config.mySystem.services.drivers.graphics.enable && config.mySystem.services.drivers.graphics.nvidia.enable) {
    # NVIDIA 显卡驱动配置
    services.xserver.videoDrivers = [ "nvidia" ];
    
    hardware.nvidia = {
      modesetting.enable = true;
      
      # 电源管理
      powerManagement.enable = config.mySystem.services.drivers.graphics.nvidia.powerManagement;
      powerManagement.finegrained = false;
      
      # 驱动类型
      open = config.mySystem.services.drivers.graphics.nvidia.openSource;
      
      # 设置工具
      nvidiaSettings = config.mySystem.services.drivers.graphics.nvidia.settings;
      
      # 包选择
      package = config.boot.kernelPackages.nvidiaPackages.stable;
    };
    
    # 环境变量
    environment.variables = {
      LIBVA_DRIVER_NAME = "nvidia";
      XDG_SESSION_TYPE = "wayland";
      GBM_BACKEND = "nvidia-drm";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
