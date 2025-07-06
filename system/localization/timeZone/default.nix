{ config, lib, pkgs, ... }:

{
  options.mySystem.localization.timeZone = {
    shanghai.enable = lib.mkEnableOption "上海时区 (Asia/Shanghai)";
    newYork.enable = lib.mkEnableOption "纽约时区 (America/New_York)";
    losAngeles.enable = lib.mkEnableOption "洛杉矶时区 (America/Los_Angeles)";
  };

  imports = [
    ./shanghai.nix
    ./newYork.nix
    ./losAngeles.nix
  ];
}
