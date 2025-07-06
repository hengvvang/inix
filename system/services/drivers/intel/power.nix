{ config, lib, pkgs, ... }:

{
  # Intel 电源管理实现
  config = lib.mkIf (config.mySystem.services.drivers.intel.enable && config.mySystem.services.drivers.intel.power.enable) {
    # Intel GPU 电源管理内核参数
    boot.kernelParams = [
      "i915.enable_rc6=1"      # 启用渲染上下文节能
      "i915.enable_dc=1"       # 启用显示上下文节能
    ] ++ lib.optionals config.mySystem.services.drivers.intel.power.turbo [
      "i915.enable_guc=2"      # 启用 GPU 微控制器用于功耗管理
    ];
    
    # 动态频率调节
    services.power-profiles-daemon.enable = lib.mkIf config.mySystem.services.drivers.intel.power.throttling true;
    
    # Intel GPU 频率控制工具
    environment.systemPackages = with pkgs; [
      intel-gpu-tools        # 包含 intel_gpu_frequency 等工具
      powertop              # 电源使用分析
    ];
    
    # GPU 频率管理脚本
    environment.systemPackages = [
      (pkgs.writeShellScriptBin "intel-gpu-freq" ''
        #!/bin/bash
        GPU_FREQ_PATH="/sys/class/drm/card0/gt_max_freq_mhz"
        GPU_MIN_PATH="/sys/class/drm/card0/gt_min_freq_mhz"
        
        case "$1" in
          max)
            if [ -f "$GPU_FREQ_PATH" ]; then
              echo "设置 Intel GPU 最大频率..."
              cat /sys/class/drm/card0/gt_RP0_freq_mhz | sudo tee "$GPU_FREQ_PATH"
            fi
            ;;
          min)
            if [ -f "$GPU_FREQ_PATH" ]; then
              echo "设置 Intel GPU 最小频率..."
              cat /sys/class/drm/card0/gt_RPn_freq_mhz | sudo tee "$GPU_FREQ_PATH"
            fi
            ;;
          auto)
            if [ -f "$GPU_FREQ_PATH" ]; then
              echo "设置 Intel GPU 自动频率..."
              cat /sys/class/drm/card0/gt_RP1_freq_mhz | sudo tee "$GPU_FREQ_PATH"
            fi
            ;;
          status)
            echo "Intel GPU 频率状态:"
            if [ -f /sys/class/drm/card0/gt_cur_freq_mhz ]; then
              echo "当前频率: $(cat /sys/class/drm/card0/gt_cur_freq_mhz) MHz"
              echo "最大频率: $(cat /sys/class/drm/card0/gt_max_freq_mhz) MHz"
              echo "最小频率: $(cat /sys/class/drm/card0/gt_min_freq_mhz) MHz"
            fi
            ;;
          *)
            echo "用法: intel-gpu-freq {max|min|auto|status}"
            ;;
        esac
      '')
    ];
    
    # GPU 电源状态监控
    systemd.services.intel-gpu-monitor = {
      description = "Intel GPU 电源监控";
      after = [ "graphical.target" ];
      
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c 'echo auto > /sys/class/drm/card0/device/power/control'";
        RemainAfterExit = true;
      };
    };
    
    # 设备权限用于频率控制
    services.udev.extraRules = ''
      # Intel GPU 频率控制权限
      KERNEL=="card[0-9]*", SUBSYSTEM=="drm", DRIVERS=="i915", GROUP="video", MODE="0664"
      ATTR{device/power/control}=="*", GROUP="video", MODE="0664"
      ATTR{gt_max_freq_mhz}=="*", GROUP="video", MODE="0664"
      ATTR{gt_min_freq_mhz}=="*", GROUP="video", MODE="0664"
    '';
  };
}
