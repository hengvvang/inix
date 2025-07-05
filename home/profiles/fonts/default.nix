{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts = {
    fonts = lib.mkEnableOption "字体配置";
  };

  imports = [
    ./fonts.nix
  ];
}