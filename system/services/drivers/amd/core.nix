{ config, lib, pkgs, ... }:

{
  # AMD 核心驱动实现
  config = lib.mkIf config.mySystem.services.drivers.amd.enable {
    # 设置显卡驱动
    services.xserver.videoDrivers = [ config.mySystem.services.drivers.amd.driver.type ];
    
    # 基础驱动包
    environment.systemPackages = with pkgs; [
      amdgpu_top    # AMD GPU 监控工具
      radeontop     # Radeon 监控工具
    ];
    
    # 内核模块
    boot.initrd.kernelModules = [ "amdgpu" ];
    boot.kernelModules = [ "amdgpu" ];
    
    # 基础硬件配置
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    
    # 环境变量
    environment.variables = {
      # 默认使用开源驱动
      AMD_VULKAN_ICD = "RADV";
    };
    
    # 设备权限
    services.udev.extraRules = ''
      # AMD GPU 设备权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="amdgpu", GROUP="video", MODE="0664"
      KERNEL=="renderD[0-9]*", SUBSYSTEM=="drm", DRIVERS=="amdgpu", GROUP="video", MODE="0664"
    '';
  };
}
