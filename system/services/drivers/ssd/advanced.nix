{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  # SSD 高级功能实现
  config = lib.mkIf (cfg.enable && cfg.advanced.enable) {
    # 电源管理优化
    services.tlp = lib.mkIf cfg.advanced.powermanagement {
      enable = true;
      settings = {
        # SSD 专用电源管理
        DISK_IDLE_SECS_ON_AC = 0;
        DISK_IDLE_SECS_ON_BAT = 2;
        MAX_LOST_WORK_SECS_ON_AC = 15;
        MAX_LOST_WORK_SECS_ON_BAT = 60;
        
        # SATA 链路电源管理
        SATA_LINKPWR_ON_AC = "med_power_with_dipm";
        SATA_LINKPWR_ON_BAT = "med_power_with_dipm";
        
        # NVMe 电源管理
        PCIE_ASPM_ON_AC = "performance";
        PCIE_ASPM_ON_BAT = "powersave";
      };
    };
    
    # 硬件加密支持
    boot.initrd.availableKernelModules = lib.optionals cfg.advanced.encryption [
      "dm-crypt"
      "aes"
      "xts"
    ];
    
    # 高级工具
    environment.systemPackages = with pkgs; lib.optionals cfg.advanced.enable [
      cryptsetup        # 磁盘加密工具
      lvm2              # LVM 管理
      mdadm             # RAID 管理
      fio               # 高级基准测试
    ];
  };
}
