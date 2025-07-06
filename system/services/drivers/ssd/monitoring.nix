{ config, lib, pkgs, ... }:

let
  cfg = config.mySystem.services.drivers.ssd;
in
{
  config = lib.mkIf cfg.enable {
    # SMART 健康监控
    services.smartd = lib.mkIf cfg.monitoring.smart {
      enable = true;
      autodetect = true;
      notifications = {
        wall.enable = true;
        mail.enable = false;
      };
    };
    
    # 温度监控
    environment.systemPackages = lib.optionals cfg.monitoring.temperature (with pkgs; [
      lm_sensors        # 硬件传感器
      hddtemp          # 硬盘温度
    ]);
    
    # 磨损监控
    environment.systemPackages = lib.optionals cfg.monitoring.wear (with pkgs; [
      smartmontools    # SMART 工具
    ]);
    
    # 性能监控
    environment.systemPackages = lib.optionals cfg.monitoring.performance (with pkgs; [
      iotop           # I/O 监控
      iostat          # I/O 统计
      hdparm          # 硬盘参数
    ]);
    
    # 监控脚本
    environment.etc."ssd-monitor.sh" = lib.mkIf cfg.monitoring.smart {
      text = ''
        #!/bin/sh
        # SSD 健康监控脚本
        echo "=== SSD SMART 状态 ==="
        smartctl -a /dev/nvme0n1 2>/dev/null || smartctl -a /dev/sda
        
        echo -e "\n=== SSD 温度 ==="
        smartctl -A /dev/nvme0n1 | grep Temperature 2>/dev/null || echo "温度信息不可用"
        
        echo -e "\n=== 磨损等级 ==="
        smartctl -A /dev/nvme0n1 | grep "Wear_Leveling\|Media_Wearout" 2>/dev/null || echo "磨损信息不可用"
      '';
      mode = "0755";
    };
    
    # 系统监控定时任务
    systemd.services.ssd-health-check = lib.mkIf cfg.monitoring.smart {
      description = "SSD Health Check";
      serviceConfig = {
        Type = "oneshot";
        ExecStart = "${pkgs.smartmontools}/bin/smartctl -H /dev/nvme0n1";
      };
    };
    
    systemd.timers.ssd-health-check = lib.mkIf cfg.monitoring.smart {
      description = "SSD Health Check Timer";
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "daily";
        Persistent = true;
      };
    };
  };
}
