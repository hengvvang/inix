{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  config = lib.mkIf cfg.enable {
    # TRIM 支持
    services.fstrim = lib.mkIf cfg.trim {
      enable = true;
      interval = "weekly";
    };

    # I/O 调度器优化
    boot.kernelParams = lib.optionals cfg.scheduler [
      "elevator=mq-deadline"  # 适合 SSD 的调度器
    ];

    # 文件系统优化
    fileSystems = lib.mkIf cfg.scheduler {
      "/" = {
        options = [ "noatime" "discard" ];  # SSD 优化选项
      };
    };

    # SMART 监控
    services.smartd = lib.mkIf cfg.monitoring.smart {
      enable = true;
      autodetect = true;
      notifications = {
        wall.enable = true;
      };
    };

    # SSD 管理和监控工具
    environment.systemPackages = with pkgs; lib.optionals cfg.monitoring.tools [
      smartmontools      # SMART 工具
      nvme-cli          # NVMe 管理工具
      hdparm            # 硬盘参数工具
      lsblk             # 块设备列表
      parted            # 分区工具
    ];

    # 系统优化
    boot.kernel.sysctl = {
      # 减少写入次数
      "vm.swappiness" = lib.mkIf cfg.scheduler 10;
      "vm.vfs_cache_pressure" = lib.mkIf cfg.scheduler 50;
    };
  };
}
