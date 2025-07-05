{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.envVar = {
    environment = lib.mkEnableOption "环境变量配置";
  };

  imports = [
    ./environment.nix
  ];
}