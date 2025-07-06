{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.services.drivers.nvidia.enable {
    # NVIDIA 显卡配置 - 从 system/hardware/hardware.nix 迁移
    services.xserver.videoDrivers = [ "nvidia" ];
    
    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = lib.mkDefault config.mySystem.services.drivers.nvidia.powerManagement;
      powerManagement.finegrained = false;
      open = config.mySystem.services.drivers.nvidia.openSource;  # 可配置开源/闭源驱动
      nvidiaSettings = config.mySystem.services.drivers.nvidia.settings;  # 可配置设置工具
    };

    # NVIDIA 相关包
    environment.systemPackages = lib.optionals config.mySystem.services.drivers.nvidia.settings [
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
