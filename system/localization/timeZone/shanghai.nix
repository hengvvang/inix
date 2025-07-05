{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.localization.timeZone.shanghai {
    time.timeZone = "Asia/Shanghai";
    
    # 中国相关的系统设置
    services.ntp.enable = true;
    
    # 确保与其他时区互斥
    assertions = [
      {
        assertion = !(config.mySystem.localization.timeZone.newYork || config.mySystem.localization.timeZone.losAngeles);
        message = "只能选择一个时区配置";
      }
    ];
  };
}
