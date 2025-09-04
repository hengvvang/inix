{ config, lib, pkgs, ... }:

{
  imports = [
    ./devenv
  ];
  options.myHome.develop = {
    enable = lib.mkEnableOption "开发环境支持";
  };
}
