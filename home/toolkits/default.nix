{ config, lib, pkgs, ... }:

{
  # 工具模块入口
  imports = lib.optionals config.myHome.toolkits.system.enable [
    ./system
  ] ++ lib.optionals config.myHome.toolkits.user.enable [
    ./user
  ];
}
