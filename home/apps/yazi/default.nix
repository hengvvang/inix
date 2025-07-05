{ config, lib, pkgs, ... }:

{
  options.myHome.apps.yazi = lib.mkEnableOption "Yazi 文件管理器";

  config = lib.mkIf config.myHome.apps.yazi {
    programs.yazi = {
      enable = true;
    };
  };
}