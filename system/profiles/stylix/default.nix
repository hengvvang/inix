{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.mySystem.profiles.stylix = {
    enable = lib.mkEnableOption "Stylix 系统级主题配置";
  };
}
