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
    
    # 监控工具软件包合并
    environment.systemPackages = lib.flatten [
      # 温度监控
      (lib.optionals cfg.monitoring.temperature (with pkgs; [
        lm_sensors        # 硬件传感器
        hddtemp          # 硬盘温度
      ]))
      # 磨损监控
      (lib.optionals cfg.monitoring.wear (with pkgs; [
        smartmontools    # SMART 工具
      ]))
      # 性能监控
      (lib.optionals cfg.monitoring.performance (with pkgs; [
        iotop           # I/O 监控
        iostat          # I/O 统计
        hdparm          # 硬盘参数
      ]))
    ];
  };
}
