{ config, lib, pkgs, ... }:

{
  imports = lib.optionals config.myHome.profiles.envVar.enable [
    ./env-var
  ] ++ lib.optionals config.myHome.profiles.fonts.enable [
    ./fonts
  ];
}