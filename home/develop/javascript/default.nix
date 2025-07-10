{ config, lib, pkgs, ... }:

{
  options.myHome.develop.javascript = {
    enable = lib.mkEnableOption "JavaScript 开发环境";
  };

  imports = [
    ./javascript.nix
  ];
}
