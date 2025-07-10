{ config, lib, pkgs, ... }:

{
  options.myHome.develop.typescript = {
    enable = lib.mkEnableOption "TypeScript 开发环境";
  };

  imports = [
    ./typescript.nix
  ];
}
