{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.amd;
in
{
  # AMD CPU 驱动和优化实现
  config = lib.mkIf (cfg.enable && cfg.cpu.enable) {
    # === CPU 微代码更新 ===
    hardware.cpu.amd.updateMicrocode = lib.mkIf cfg.cpu.microcode.enable (
      lib.mkDefault config.hardware.enableRedistributableFirmware
    );

    # === 早期微代码加载 ===
    boot.initrd.availableKernelModules = lib.mkIf cfg.cpu.microcode.early [
      "amd64-microcode"
    ];

    # === CPU 频率调节器配置 ===
    powerManagement = {
      enable = cfg.cpu.power.enable;
      cpuFreqGovernor = lib.mkIf cfg.cpu.power.enable cfg.cpu.performance.governor;
    };

    # === 内核参数优化 ===
    boot.kernelParams = [
      # AMD CPU 基础优化
      "amd_pstate=active"           # 启用 AMD P-State 驱动
    ] ++ lib.optionals cfg.cpu.performance.turbo [
      # Turbo Boost 支持
      "processor.max_cstate=1"      # 限制 C-State 以提升性能
    ] ++ lib.optionals (!cfg.cpu.power.cStates) [
      # 禁用深度睡眠状态 (性能优先)
      "idle=poll"
    ];

    # === 内核模块配置 ===
    boot.kernelModules = [
      "k10temp"                     # AMD CPU 温度监控
      "zenpower"                    # AMD CPU 功耗监控 (如果可用)
    ] ++ lib.optionals cfg.cpu.power.pStates [
      "amd_pstate"                  # AMD P-State 驱动
    ];

    # === CPU 性能监控工具 ===
    environment.systemPackages = with pkgs; [
      # CPU 信息和监控
      lscpu                         # CPU 信息查看
      cpufrequtils                  # CPU 频率工具
      cpupower                      # CPU 功耗控制

      # 温度和传感器监控
      lm_sensors                    # 硬件传感器
      psensor                       # 图形化传感器监控

      # 系统监控工具
      htop                          # 进程监控
      iotop                         # IO 监控
      powertop                      # 电源使用分析
    ] ++ lib.optionals cfg.cpu.performance.turbo [
      # 性能调优工具
      stress                        # CPU 压力测试
      stress-ng                     # 新版压力测试
    ];

    # === CPU 电源管理服务 ===
    services = {
      # 电源配置文件守护进程
      power-profiles-daemon.enable = lib.mkIf cfg.cpu.power.enable true;

      # 热量管理 (如果需要)
      thermald.enable = lib.mkIf cfg.cpu.power.enable false;  # AMD 不需要 thermald
    };

    # === CPU 优化服务 ===
    systemd.services.amd-cpu-optimization = lib.mkIf cfg.cpu.power.enable {
      description = "AMD CPU 性能和电源优化";
      wantedBy = [ "multi-user.target" ];
      after = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.writeShellScript "amd-cpu-opt" ''
          # 设置 CPU 调节器
          ${pkgs.cpupower}/bin/cpupower frequency-set -g ${cfg.cpu.performance.governor}

          # AMD P-State 设置 (如果支持)
          if [ -d /sys/devices/system/cpu/cpu0/cpufreq ]; then
            echo ${cfg.cpu.performance.governor} > /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor || true
          fi

          ${lib.optionalString cfg.cpu.performance.turbo ''
            # 启用 Turbo Boost
            echo 0 > /sys/devices/system/cpu/cpufreq/boost || true

            # 设置性能偏好
            echo performance > /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference || true
          ''}

          ${lib.optionalString cfg.cpu.power.cStates ''
            # 启用 C-States (电源管理)
            ${pkgs.cpupower}/bin/cpupower idle-set -E || true
          ''}
        ''}";
        RemainAfterExit = true;
      };
    };

    # === 环境变量配置 ===
    environment.variables = {
      # AMD CPU 特定环境变量
      AMD_PSTATE_UT = lib.mkIf cfg.cpu.power.pStates "1";
    };

    # === 用户组权限 ===
    users.groups.sensors = {};

    # === 设备权限配置 ===
    services.udev.extraRules = ''
      # AMD CPU 温度传感器权限
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTR{name}=="k10temp", GROUP="sensors", MODE="0664"
      SUBSYSTEM=="hwmon", KERNEL=="hwmon*", ATTR{name}=="zenpower", GROUP="sensors", MODE="0664"

      # CPU 频率控制权限
      KERNEL=="cpu_dma_latency", GROUP="audio", MODE="0664"
      SUBSYSTEM=="cpu", ATTR{online}=="*", GROUP="wheel", MODE="0664"
    '';

    # === CPU 调度优化 ===
    systemd.services.amd-cpu-scheduler = lib.mkIf (cfg.cpu.performance.governor == "performance") {
      description = "AMD CPU 调度器优化";
      wantedBy = [ "multi-user.target" ];

      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash -c '''
          # 设置 CPU 调度策略
          echo 0 > /proc/sys/kernel/sched_rt_runtime_us || true
          echo 950000 > /proc/sys/kernel/sched_rt_period_us || true

          # 优化进程调度
          echo 1 > /proc/sys/kernel/sched_autogroup_enabled || true
        '''";
        RemainAfterExit = true;
      };
    };
  };
}
