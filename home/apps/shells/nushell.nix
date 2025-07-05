{ config, lib, pkgs, ... }:

{
  options.myHome.apps.shells.nushell.enable = lib.mkEnableOption "Nushell 配置";

  config = lib.mkIf config.myHome.apps.shells.nushell.enable {
  # Nushell 配置
  programs.nushell = {
    enable = true;
  };
  };
}