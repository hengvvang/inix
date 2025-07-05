{ config, lib, pkgs, ... }:

{
  options.myHome.toolkits.system = {
    utilities = lib.mkEnableOption "系统实用工具";
    hardware = lib.mkEnableOption "系统硬件工具";
    network = lib.mkEnableOption "网络工具";
    monitor = lib.mkEnableOption "系统监控工具";
  };

  imports = [
    ./utilities.nix
    ./hardware.nix
    ./network.nix
    ./monitor.nix
  ];
}