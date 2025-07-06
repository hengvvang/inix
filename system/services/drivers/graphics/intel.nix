{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.mySystem.services.drivers.enable && config.mySystem.services.drivers.graphics.enable && config.mySystem.services.drivers.graphics.intel.enable) {
    # Intel 显卡驱动配置
    services.xserver.videoDrivers = [ "modesetting" ];
    
    # 硬件加速
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    
    # 环境变量
    environment.variables = {
      LIBVA_DRIVER_NAME = "iHD";
    };
  };
}
