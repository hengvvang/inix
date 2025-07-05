{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口 - 设置常用模块默认开启
  config = {
    myHome = {
      # 应用程序模块 - 默认开启，因为是用户日常必需
      apps.enable = lib.mkDefault true;
      # 开发环境 - 默认开启，因为这是开发者机器
      development.enable = lib.mkDefault true;
      # 配置文件 - 默认开启，字体和环境变量很重要
      profiles.enable = lib.mkDefault true;
      # 工具包 - 默认关闭，让用户选择需要的工具
      toolkits.enable = lib.mkDefault false;
    };
  };

  imports = [
    ./apps
    ./toolkits
    ./development
    ./profiles
  ];
}
