{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.localization.timeZone.newYork.enable {
    time.timeZone = "America/New_York";
    
    # 美国东部时区相关设置
    services.ntp.enable = true;
    
    # 确保与其他时区互斥
    assertions = [
      {
        assertion = !(config.mySystem.localization.timeZone.shanghai.enable || config.mySystem.localization.timeZone.losAngeles.enable);
        message = "只能选择一个时区配置";
      }
    ];
  };
}
