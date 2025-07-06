{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  config = lib.mkIf cfg.enable {
    # 电源管理
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
      };
    };
    
    # 加密支持
    boot.initrd.luks.devices = lib.mkIf cfg.advanced.encryption {};
    
    # RAID 支持
    boot.swraid.enable = lib.mkIf cfg.advanced.raid true;
    
    # 缓存优化
    services.bcache = lib.mkIf cfg.advanced.cache {
      enable = true;
    };
    
    # 高级工具
    environment.systemPackages = lib.mkMerge [
      (lib.mkIf cfg.advanced.powermanagement (with pkgs; [
        tlp
        powertop
      ]))
      
      (lib.mkIf cfg.advanced.encryption (with pkgs; [
        cryptsetup
        libsecret
      ]))
      
      (lib.mkIf cfg.advanced.raid (with pkgs; [
        mdadm
        smartmontools
      ]))
      
      (lib.mkIf cfg.advanced.cache (with pkgs; [
        bcache-tools
      ]))
    ];
    
    # 高级内核参数
    boot.kernel.sysctl = lib.mkMerge [
      (lib.mkIf cfg.advanced.powermanagement {
        "vm.laptop_mode" = 5;
      })
      
      (lib.mkIf cfg.advanced.cache {
        "vm.zone_reclaim_mode" = 0;
      })
    ];
  };
}
