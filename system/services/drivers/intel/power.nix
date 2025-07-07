{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.intel;
in
{
  # Intel GPU 电源管理实现
  config = lib.mkIf (cfg.enable && cfg.power.enable) {
    # Intel GPU 电源管理内核参数
    boot.kernelParams = [
      "i915.enable_rc6=1"      # 启用渲染上下文节能
      "i915.enable_dc=1"       # 启用显示上下文节能
      "i915.enable_fbc=1"      # 启用帧缓冲压缩
    ] ++ lib.optionals cfg.power.turbo [
      "i915.enable_guc=2"      # 启用 GPU 微控制器用于功耗管理
      "i915.enable_huc=1"      # 启用硬件加速微控制器
    ];
    
    # 电源管理服务
    services.power-profiles-daemon.enable = true;
    services.thermald.enable = true;
    
    # Intel GPU 电源管理工具
    environment.systemPackages = with pkgs; [
      powertop              # 电源使用分析
      intel-gpu-tools       # GPU 监控工具
    ];
    
    # GPU 电源状态优化
    systemd.services.intel-gpu-power = {
      description = "Intel GPU 电源优化";
      wantedBy = [ "multi-user.target" ];
      after = [ "graphical.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '''
          # 启用 GPU 运行时电源管理
          echo auto > /sys/class/drm/card*/device/power/control || true
          
          # 设置合理的最小频率 (省电)
          echo 300 > /sys/class/drm/card*/gt_min_freq_mhz || true
        '''";
        RemainAfterExit = true;
      };
    };
    
    # Turbo 性能优化
    systemd.services.intel-gpu-turbo = lib.mkIf cfg.power.turbo {
      description = "Intel GPU Turbo 性能优化";
      wantedBy = [ "multi-user.target" ];
      after = [ "intel-gpu-power.service" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '''
          # 提高最大频率
          echo 1200 > /sys/class/drm/card*/gt_max_freq_mhz || true
          
          # 启用动态频率调节
          echo 1 > /sys/class/drm/card*/gt_boost_freq_mhz || true
        '''";
        RemainAfterExit = true;
      };
    };
    
    # GPU 电源管理权限
    services.udev.extraRules = ''
      # Intel GPU 电源控制权限
      SUBSYSTEM=="drm", KERNEL=="card*", ATTR{device/power/control}="auto"
      SUBSYSTEM=="drm", KERNEL=="card*", DRIVERS=="i915", GROUP="video", MODE="0664"
      
      # GPU 频率控制权限 (当启用 turbo 时)
      ${lib.optionalString cfg.power.turbo ''
        ATTR{gt_max_freq_mhz}=="*", GROUP="video", MODE="0664"
        ATTR{gt_min_freq_mhz}=="*", GROUP="video", MODE="0664"
        ATTR{gt_boost_freq_mhz}=="*", GROUP="video", MODE="0664"
      ''}
    '';
  };
}
