{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.system.enable = lib.mkEnableOption "系统工具" // {
    default = false;
  };

  config = lib.mkIf config.myHome.toolkits.system.enable {
    # 设置系统工具的默认值
    myHome.toolkits.system = {
      utilities.enable = lib.mkDefault true;
      hardware.enable = lib.mkDefault true;
      network.enable = lib.mkDefault true;
      monitor.enable = lib.mkDefault true;
    };
  };

  imports = [
    ./utilities.nix
    ./hardware.nix
    ./network.nix
    ./monitor.nix
  ];
}