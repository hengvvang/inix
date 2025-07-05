{ config, lib, pkgs, ... }:

{
  imports = [
    ../lib/options.nix
  ] ++ lib.optionals config.mySystem.desktop.enable [
    ./desktop-environment.nix
  ] ++ lib.optionals config.mySystem.hardware.enable [
    ./hardware.nix
  ] ++ lib.optionals config.mySystem.localization.enable [
    ./localization.nix
  ] ++ lib.optionals config.mySystem.users.enable [
    ./users.nix
  ] ++ lib.optionals config.mySystem.packages.enable [
    ./packages.nix
  ];
}
