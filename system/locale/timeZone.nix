{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.locale.timeZone.enable {
    time.timeZone = 
      if config.mySystem.locale.timeZone.preset == "shanghai" then "Asia/Shanghai"
      else if config.mySystem.locale.timeZone.preset == "newYork" then "America/New_York"
      else if config.mySystem.locale.timeZone.preset == "losAngeles" then "America/Los_Angeles"
      else if config.mySystem.locale.timeZone.preset == "london" then "Europe/London"
      else if config.mySystem.locale.timeZone.preset == "tokyo" then "Asia/Tokyo"
      else "Asia/Shanghai";  # 默认值
    
    # 网络时间同步
    services.ntp.enable = true;
    
    # 根据时区设置额外的区域设置
    i18n.extraLocaleSettings = lib.mkMerge [
      (lib.mkIf (config.mySystem.locale.timeZone.preset == "shanghai") {
        LC_TIME = "zh_CN.UTF-8";
      })
      (lib.mkIf (lib.elem config.mySystem.locale.timeZone.preset ["newYork" "losAngeles"]) {
        LC_TIME = "en_US.UTF-8";
      })
      (lib.mkIf (config.mySystem.locale.timeZone.preset == "london") {
        LC_TIME = "en_GB.UTF-8";
      })
      (lib.mkIf (config.mySystem.locale.timeZone.preset == "tokyo") {
        LC_TIME = "ja_JP.UTF-8";
      })
    ];
  };
}
