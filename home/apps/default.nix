{ config, lib, pkgs, ... }:

{
  options.myHome.apps.enable = lib.mkEnableOption "应用程序模块" // {
    default = false;
  };

  config = lib.mkIf config.myHome.apps.enable {
    myHome.apps = {
      # 文件管理器 - 默认开启，是基础工具
      yazi.enable = lib.mkDefault true;
      # 编辑器 - 默认开启，是核心工具
      editors.enable = lib.mkDefault true;
      # Shell配置 - 默认开启，用户交互必需
      shells.enable = lib.mkDefault true;
      # 终端 - 默认关闭，让用户选择终端
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