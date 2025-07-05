{ config, lib, pkgs, ... }:

{
  options.mySystem.users = {
    enable = lib.mkEnableOption "用户配置";
  };

  imports = [
    ./users.nix
  ];
}
