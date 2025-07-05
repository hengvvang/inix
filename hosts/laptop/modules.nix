{ lib, ... }:

{
  # 为 laptop 主机启用所有模块
  mySystem = {
    desktop.enable = lib.mkDefault true;
    hardware.enable = lib.mkDefault true;
    localization.enable = lib.mkDefault true;
    users.enable = lib.mkDefault true;
    packages.enable = lib.mkDefault true;
  };

  myHome = {
    apps.enable = lib.mkDefault true;
    development.enable = lib.mkDefault true;
    profiles.enable = lib.mkDefault true;
    toolkits.enable = lib.mkDefault true;
  };
}
