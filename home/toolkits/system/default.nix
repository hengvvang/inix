{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.system.enable = lib.mkEnableOption "系统工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.system.enable {
    # 直接配置而不设置过深的层次结构
  };

  imports = [
    ./utilities.nix
    ./hardware.nix
    ./network.nix
    ./monitor.nix
  ];
}