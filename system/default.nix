{ config, lib, pkgs, ... }:

{
  # 系统模块入口 - 仅做导入，类似 home/default.nix
  imports = [
    ./desktop
    ./hardware
    ./users
    ./packages
    ./localization
    ./services
  ];

  mySystem = {
    desktop.cosmic.enable = lib.mkDefault false;
    hardware.enable = lib.mkDefault false;
    users.enable = lib.mkDefault false;
    packages.enable = lib.mkDefault false;
    localization = {
      timeZone.shanghai.enable = lib.mkDefault false;
      timeZone.newYork.enable = lib.mkDefault false;
      timeZone.losAngeles.enable = lib.mkDefault false;
      inputMethod.fcitx5.enable = lib.mkDefault false;
      inputMethod.ibus.enable = lib.mkDefault false;
    };
    services = {
      docker.enable = lib.mkDefault false;
      ssh.enable = lib.mkDefault false;
    };
  };
}
