{ config, lib, pkgs, ... }:

{
  config = lib.mkMerge [
    # 上海时区配置
    (lib.mkIf config.mySystem.locale.timeZone.shanghai.enable {
      time.timeZone = "Asia/Shanghai";
      
      # 中国相关的系统设置
      services.ntp.enable = true;
      
      # 确保与其他时区互斥
      assertions = [
        {
          assertion = !(config.mySystem.locale.timeZone.newYork.enable || config.mySystem.locale.timeZone.losAngeles.enable);
          message = "只能选择一个时区配置";
        }
      ];
    })

    # 纽约时区配置
    (lib.mkIf config.mySystem.locale.timeZone.newYork.enable {
      time.timeZone = "America/New_York";
      
      # 美国东部时区相关设置
      services.ntp.enable = true;
      
      # 确保与其他时区互斥
      assertions = [
        {
          assertion = !(config.mySystem.locale.timeZone.shanghai.enable || config.mySystem.locale.timeZone.losAngeles.enable);
          message = "只能选择一个时区配置";
        }
      ];
    })

    # 洛杉矶时区配置
    (lib.mkIf config.mySystem.locale.timeZone.losAngeles.enable {
      time.timeZone = "America/Los_Angeles";
      
      # 美国西部时区相关设置
      services.ntp.enable = true;
      
      # 确保与其他时区互斥
      assertions = [
        {
          assertion = !(config.mySystem.locale.timeZone.shanghai.enable || config.mySystem.locale.timeZone.newYork.enable);
          message = "只能选择一个时区配置";
        }
      ];
    })
  ];
}
