{ lib, ... }:

{
  # 系统模块选项
  options.mySystem = {
    desktop.enable = lib.mkEnableOption "桌面环境";
    hardware.enable = lib.mkEnableOption "硬件配置";
    localization.enable = lib.mkEnableOption "本地化配置";
    users.enable = lib.mkEnableOption "用户配置";
    packages.enable = lib.mkEnableOption "系统包配置";
  };

  # Home Manager 模块选项
  options.myHome = {
    # Apps 模块
    apps = {
      enable = lib.mkEnableOption "应用程序模块";
      editors.enable = lib.mkEnableOption "编辑器配置";
      shells.enable = lib.mkEnableOption "Shell 配置";
      terminals.enable = lib.mkEnableOption "终端配置";
      yazi.enable = lib.mkEnableOption "Yazi 文件管理器";
    };

    # Development 模块
    development = {
      enable = lib.mkEnableOption "开发环境模块";
      embedded.enable = lib.mkEnableOption "嵌入式开发";
      languages.enable = lib.mkEnableOption "编程语言支持";
      versionControl.enable = lib.mkEnableOption "版本控制工具";
    };

    # Profiles 模块
    profiles = {
      enable = lib.mkEnableOption "配置文件模块";
      envVar.enable = lib.mkEnableOption "环境变量配置";
      fonts.enable = lib.mkEnableOption "字体配置";
    };

    # Toolkits 模块
    toolkits = {
      enable = lib.mkEnableOption "工具包模块";
      system.enable = lib.mkEnableOption "系统工具";
      user.enable = lib.mkEnableOption "用户工具";
    };
  };
}
