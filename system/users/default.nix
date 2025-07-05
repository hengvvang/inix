{ config, lib, pkgs, ... }:

{
  options.mySystem.users = lib.mkEnableOption "用户配置";

  imports = [
    ./users.nix
  ];
}
