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
    
    # 性能监控工具
    environment.systemPackages = with pkgs; [
      amdgpu_top        # AMD GPU 监控
      radeontop         # Radeon 性能监控
      
      # 温度监控
      lm_sensors
      
      # 系统监控
      htop
      iotop
    ];
    
    # GPU 性能模式脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "amd-perf-mode" ''
        #!/bin/bash
        case "$1" in
          high)
            echo "设置高性能模式..."
            echo "high" | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
            ;;
          low)
            echo "设置节能模式..."
            echo "low" | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
            ;;
          auto)
            echo "设置自动模式..."
            echo "auto" | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
            ;;
          manual)
            echo "设置手动模式..."
            echo "manual" | sudo tee /sys/class/drm/card*/device/power_dpm_force_performance_level
            ;;
          status)
            echo "当前性能模式:"
            cat /sys/class/drm/card*/device/power_dpm_force_performance_level
            ;;
          *)
            echo "用法: amd-perf-mode {high|low|auto|manual|status}"
            ;;
        esac
      '')
    ];
    
    # 设备权限用于性能调节
    services.udev.extraRules = ''
      # AMD GPU 性能控制权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="amdgpu", GROUP="video", MODE="0664"
      ATTR{device/power_dpm_force_performance_level}=="*", GROUP="video", MODE="0664"
      ATTR{device/pp_power_profile_mode}=="*", GROUP="video", MODE="0664"
    '';
  };
}
