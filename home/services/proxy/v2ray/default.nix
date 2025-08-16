{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.services.enable && config.myHome.services.v2ray.enable) {

    xdg.configFile = {
    };
  };
}
