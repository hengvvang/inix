{ config, lib, pkgs, ... }:

{
  # Home Manager 用户级配置入口
  imports = [
    ../lib/options.nix
  ] ++ lib.optionals config.myHome.apps.enable [
    ./apps
  ] ++ lib.optionals config.myHome.toolkits.enable [
    ./toolkits
  ] ++ lib.optionals config.myHome.development.enable [
    ./development
  ] ++ lib.optionals config.myHome.profiles.enable [
    ./profiles
  ];
}
