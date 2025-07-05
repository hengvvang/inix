{ config, lib, pkgs, ... }:

{
  options.myHome.apps.enable = lib.mkEnableOption "应用程序模块";

  config = lib.mkIf config.myHome.apps.enable {
    myHome.apps.yazi.enable = lib.mkDefault true;
  };

  imports = [
    ./editors
    ./terminals
    ./shells
    ./yazi
  ];
}