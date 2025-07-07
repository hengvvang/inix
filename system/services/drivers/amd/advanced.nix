{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.amd;
in
{
  # AMD 高级功能实现
  config = lib.mkIf cfg.enable {
    # === ROCm 计算平台 ===
    systemd.services.rocm-setup = lib.mkIf cfg.advanced.rocm {
      description = "ROCm 计算平台设置";
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/module/amdgpu/parameters/noretry'";
        RemainAfterExit = true;
      };
    };
    
    # === 风扇控制支持 ===
    systemd.services.amd-fan-control = lib.mkIf cfg.advanced.fanControl {
      description = "AMD 风扇控制";
      wantedBy = [ "multi-user.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo 1 > /sys/class/drm/card*/device/hwmon/hwmon*/pwm1_enable || true'";
        RemainAfterExit = true;
      };
    };
    
    # === 合并的系统包 ===
    environment.systemPackages = with pkgs; []
      ++ lib.optionals cfg.advanced.rocm [
        # ROCm 运行环境
        rocm-opencl-icd
        rocm-runtime
        rocm-device-libs
        rocm-cmake
        rocminfo
      ]
      ++ lib.optionals cfg.advanced.overclocking [
        # 超频工具
        radeon-profile    # Radeon 配置工具
        corectrl          # AMD GPU 控制工具
      ];
    
    # === 环境变量 ===
    environment.variables = lib.mkIf cfg.advanced.rocm {
      ROCM_PATH = "${pkgs.rocm-runtime}";
      HIP_PATH = "${pkgs.rocm-runtime}";
    };
    
    # === 超频相关内核参数 ===
    boot.kernelParams = lib.mkIf cfg.advanced.overclocking [
      "amdgpu.ppfeaturemask=0xffffffff"
    ];
    
    # === 设备权限配置 ===
    services.udev.extraRules = lib.mkIf (cfg.advanced.fanControl || cfg.advanced.overclocking) ''
      # AMD GPU 设备权限
      SUBSYSTEM=="drm", KERNEL=="card*", GROUP="video", MODE="0664"
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", GROUP="video", MODE="0664"
      
      # AMD GPU 风扇和功耗控制权限
      KERNEL=="card*", SUBSYSTEM=="drm", ATTRS{vendor}=="0x1002", TAG+="uaccess"
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTR{name}=="amdgpu", TAG+="uaccess"
    '';
    
    # 确保用户在 video 组中
    users.groups.video = {};
  };
}
