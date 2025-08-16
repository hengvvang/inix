{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.services.enable && config.myHome.services.mihomo.enable) {

    xdg.configFile = {
      "mihomo/config.yaml".source = ./config.yaml;
    };
  };
}
