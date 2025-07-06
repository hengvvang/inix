{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  config = lib.mkIf cfg.enable {
    # TRIM 支持
    services.fstrim = lib.mkIf cfg.optimization.trim {
      enable = true;
      interval = "weekly";
    };
    
    # I/O 调度器优化
    # 内核参数优化
    boot.kernelParams = lib.optionals cfg.optimization.scheduler [
      "elevator=mq-deadline"  # 多队列调度器
    ];
    
    # 内核 sysctl 优化合并
    boot.kernel.sysctl = lib.mkMerge [
      # 交换分区优化
      (lib.mkIf cfg.optimization.swap {
        "vm.swappiness" = 10;          # 减少交换使用
        "vm.vfs_cache_pressure" = 50;  # 减少缓存压力
        "vm.dirty_ratio" = 15;         # 脏页比例
        "vm.dirty_background_ratio" = 5; # 后台脏页比例
      })
      # 文件系统优化
      (lib.mkIf cfg.optimization.filesystem {
        "vm.page-cluster" = 0;         # 禁用页面聚集
      })
    ];
    
    # SSD 特定文件系统选项
    fileSystems = lib.mkIf cfg.optimization.filesystem {
      "/" = {
        options = [ "noatime" "ssd" "discard" ];
      };
    };
    
    # 内核模块
    boot.kernelModules = [
      "nvme"
      "nvme-core"
    ];
  };
}
