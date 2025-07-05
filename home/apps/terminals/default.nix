{ config, lib, pkgs, ... }:

{
  options.myHome.apps.terminals.enable = lib.mkEnableOption "终端配置" // {
    default = false;
  };

  config = lib.mkIf config.myHome.apps.terminals.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./ghostty.nix
  ];
}