{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.nvidia.enable {
    # NVIDIA 显卡配置 - 完全原子化
    services.xserver.videoDrivers = [ "nvidia" ];
    
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = lib.mkDefault config.mySystem.services.drivers.nvidiaPowerManagement.enable;
      powerManagement.finegrained = false;
      open = config.mySystem.services.drivers.nvidiaOpenSource.enable;  # 原子化开源/闭源选项
      nvidiaSettings = config.mySystem.services.drivers.nvidiaSettings.enable;  # 原子化设置工具选项
    };

    # NVIDIA 相关包
    environment.systemPackages = lib.optionals config.mySystem.services.drivers.nvidiaSettings.enable [
      pkgs.nvidia-settings
    ];

    # 确保 OpenGL 支持
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
}
