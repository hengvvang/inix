{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  options.myHome.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix Home Manager 主题配置";
  };
}
