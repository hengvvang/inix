{ config, lib, pkgs, ... }:

{
  # AMD 性能调优实现
  config = lib.mkIf config.mySystem.services.drivers.amd.enable {
    # 功耗配置
    boot.kernelParams = lib.optionals (config.mySystem.services.drivers.amd.performance.powerProfile != "default") [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    
    # 风扇控制支持
    systemd.services.amd-fan-control = lib.mkIf config.mySystem.services.drivers.amd.performance.fanControl {
      description = "AMD 风扇控制";
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/class/drm/card0/device/hwmon/hwmon*/pwm1_enable'";
        RemainAfterExit = true;
      };
    };
    
    # 超频支持工具
    environment.systemPackages = lib.optionals config.mySystem.services.drivers.amd.performance.overclocking (with pkgs; [
      radeon-profile    # Radeon 配置工具
      corectrl          # AMD GPU 控制工具
    ]);
    
    # 设备权限用于性能调节
    services.udev.extraRules = ''
      # AMD GPU 性能控制权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="amdgpu", GROUP="video", MODE="0664"
      ATTR{device/power_dpm_force_performance_level}=="*", GROUP="video", MODE="0664"
      ATTR{device/pp_power_profile_mode}=="*", GROUP="video", MODE="0664"
    '';
  };
}
