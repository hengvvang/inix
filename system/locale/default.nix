{ config, lib, pkgs, ... }:

{
  options.mySystem.locale = {
    enable = lib.mkEnableOption "本地化配置支持";
    
    # 时区配置选项
    timeZone = {
      enable = lib.mkEnableOption "时区配置支持";
      shanghai.enable = lib.mkEnableOption "上海时区 (Asia/Shanghai)";
      newYork.enable = lib.mkEnableOption "纽约时区 (America/New_York)";
      losAngeles.enable = lib.mkEnableOption "洛杉矶时区 (America/Los_Angeles)";
    };
    
    # 输入法配置选项
    inputMethod = {
      enable = lib.mkEnableOption "输入法配置支持";
      fcitx5.enable = lib.mkEnableOption "Fcitx5 输入法框架";
      ibus.enable = lib.mkEnableOption "IBus 输入法框架";
    };
  };

  imports = [
    ./timeZone.nix
    ./inputMethod.nix
  ];
}
