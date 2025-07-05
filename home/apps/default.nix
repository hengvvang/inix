{ config, lib, pkgs, ... }:

{
  imports = lib.optionals config.myHome.apps.editors.enable [
    ./editors
  ] ++ lib.optionals config.myHome.apps.terminals.enable [
    ./terminals
  ] ++ lib.optionals config.myHome.apps.shells.enable [
    ./shells
  ] ++ lib.optionals config.myHome.apps.yazi.enable [
    ./yazi
  ];
}