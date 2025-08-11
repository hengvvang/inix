{ config, lib, pkgs, ... }:

{
    xdg.configFile = {
      "mihomo/config.yaml".source = ./config.yaml;
    };
}
