{ config, lib, pkgs, ... }:

{
  options.myPkgs = {
    enable = lib.mkEnableOption "包管理模块支持";
  };

  imports = [
    ./toolkits
  ];
}

