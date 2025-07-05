{ config, lib, pkgs, ... }:

{
  options.myHome.apps.enable = lib.mkEnableOption "应用程序模块";

  config = lib.mkIf config.myHome.apps.enable {
    myHome.apps = {
      # 编辑器 - 核心工具，默认开启
      editors.enable = lib.mkDefault true;
      # 文件管理器 - 基础工具，默认开启
      yazi.enable = lib.mkDefault true;
      # Shell配置 - 用户交互必需，默认开启
      shells.enable = lib.mkDefault true;
      # 终端 - 可选，默认关闭
      terminals.enable = lib.mkDefault false;
    };
  };

  imports = [
    ./editors
    ./terminals
    ./shells
    ./yazi
  ];
}