{ config, lib, pkgs, ... }:

{
  options.myHome.apps.terminals.enable = lib.mkEnableOption "终端配置";

  config = lib.mkIf config.myHome.apps.terminals.enable {
    # 终端层默认配置：ghostty作为现代终端默认开启
    myHome.apps.terminals = {
      ghostty.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./ghostty.nix
  ];
}