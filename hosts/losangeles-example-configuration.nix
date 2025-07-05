# 洛杉矶时区示例配置
{ config, lib, pkgs, ... }:

{
  imports = [
    ../system
  ];

  # 系统基础配置
  mySystem = {
    # 本地化配置 - 直接选择具体选项即可获得完整配置
    localization = {
      # 时区配置 - 选择洛杉矶时区
      timeZone.losAngeles = true;
      
      # 输入法配置 - 选择 Fcitx5（会自动包含 locale 和字体）
      inputMethod.fcitx5 = true;
    };
  };

  # 其他系统配置...
  system.stateVersion = "24.05";
}
