{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.enable = lib.mkEnableOption "配置文件模块";

  config = lib.mkIf config.myHome.profiles.enable {
    
  };

  imports = [
    ./env-var
    ./fonts
  ];
}