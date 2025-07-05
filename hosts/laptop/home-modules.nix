{ lib, ... }:

{
  # 为 laptop 主机启用所有 Home Manager 模块
  myHome = {
    apps = {
      enable = lib.mkDefault true;
      yazi.enable = lib.mkDefault true;
      editors.enable = lib.mkDefault true;
    };
    development.enable = lib.mkDefault true;
    profiles.enable = lib.mkDefault true;
    toolkits.enable = lib.mkDefault true;
  };
}
