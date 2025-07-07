{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts = {
    enable = lib.mkEnableOption "字体配置支持";
    fonts.enable = lib.mkEnableOption "字体包";
  };

  imports = [
    ./fonts.nix
  ];
}