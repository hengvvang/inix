{ config, lib, pkgs, ... }:

{
  options.mySystem.localization = {
    enable = lib.mkEnableOption "本地化配置";
    
    timeZone = {
      shanghai = lib.mkEnableOption "上海时区 (Asia/Shanghai)";
      newYork = lib.mkEnableOption "纽约时区 (America/New_York)";
      losAngeles = lib.mkEnableOption "洛杉矶时区 (America/Los_Angeles)";
    };
    
    inputMethod = {
      fcitx5 = lib.mkEnableOption "Fcitx5 输入法";
      ibus = lib.mkEnableOption "IBus 输入法";
    };
  };

  config = lib.mkIf config.mySystem.localization.enable {
    # 设置合理的默认值
    mySystem.localization = {
      # 默认使用上海时区
      timeZone.shanghai = lib.mkDefault true;
      # 默认使用 Fcitx5 输入法
      inputMethod.fcitx5 = lib.mkDefault true;
    };

    # 基础本地化设置
    i18n.defaultLocale = "zh_CN.UTF-8";
    
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "zh_CN.UTF-8";
      LC_IDENTIFICATION = "zh_CN.UTF-8";
      LC_MEASUREMENT = "zh_CN.UTF-8";
      LC_MONETARY = "zh_CN.UTF-8";
      LC_NAME = "zh_CN.UTF-8";
      LC_NUMERIC = "zh_CN.UTF-8";
      LC_PAPER = "zh_CN.UTF-8";
      LC_TELEPHONE = "zh_CN.UTF-8";
      LC_TIME = "zh_CN.UTF-8";
    };

    # 字体支持
    fonts.packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      source-han-sans
      source-han-serif
      wqy_microhei
      wqy_zenhei
    ];
  };

  imports = [
    ./timeZone
    ./inputMethod
  ];
}