{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.shells.nushell {
  # Nushell 配置
  programs.nushell = {
    enable = true;
  };
  };
}