{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.envVar = {
    environment.enable = lib.mkEnableOption "环境变量配置";
  };

  imports = [
    ./environment.nix
  ];
}