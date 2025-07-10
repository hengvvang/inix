{ config, lib, pkgs, ... }:

{
  options.myHome.develop.python = {
    enable = lib.mkEnableOption "Python 开发环境";
  };

  imports = [
    ./python.nix
  ];
}
