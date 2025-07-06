{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.localization.timeZone.losAngeles.enable {
    time.timeZone = "America/Los_Angeles";
    
    # 美国西部时区相关设置
    services.ntp.enable = true;
    
    # 确保与其他时区互斥
    assertions = [
      {
        assertion = !(config.mySystem.localization.timeZone.shanghai.enable || config.mySystem.localization.timeZone.newYork.enable);
        message = "只能选择一个时区配置";
      }
    ];
  };
}
