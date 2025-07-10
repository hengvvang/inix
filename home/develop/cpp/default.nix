{ config, lib, pkgs, ... }:

{
  options.myHome.develop.cpp = {
    enable = lib.mkEnableOption "C/C++ 开发环境";
    embedded.enable = lib.mkEnableOption "C/C++ 嵌入式开发环境";
  };

  imports = [
    ./cpp.nix
  ];
}
