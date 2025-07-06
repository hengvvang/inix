{ config, lib, pkgs, ... }:

{
  # Intel 核心驱动实现
  config = lib.mkIf config.mySystem.services.drivers.intel.enable {
    # 设置显卡驱动
    services.xserver.videoDrivers = [ config.mySystem.services.drivers.intel.driver.type ];
    
    # 基础硬件配置
    hardware.opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
    
    # 内核模块
    boot.initrd.kernelModules = [ "i915" ];
    boot.kernelModules = [ "i915" ];
    
    # Intel GPU 工具
    environment.systemPackages = with pkgs; [
      intel-gpu-tools   # Intel GPU 监控和调试工具
      libva-utils       # VA-API 工具
    ];
    
    # 设备权限
    services.udev.extraRules = ''
      # Intel GPU 设备权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="i915", GROUP="video", MODE="0664"
      KERNEL=="renderD[0-9]*", SUBSYSTEM=="drm", DRIVERS=="i915", GROUP="video", MODE="0664"
    '';
    
    # Intel 特定内核参数
    boot.kernelParams = [
      "i915.enable_guc=2"    # 启用 GuC 和 HuC 固件
      "i915.enable_fbc=1"    # 启用帧缓冲压缩
    ];
  };
}
