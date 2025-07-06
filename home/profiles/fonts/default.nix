{ config, lib, pkgs, ... }:

{
  options.myHome.profiles.fonts = {
    fonts.enable = lib.mkEnableOption "字体配置";
  };

  imports = [
    ./fonts.nix
  ];
}