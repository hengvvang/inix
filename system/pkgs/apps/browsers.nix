{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.mySystem.pkgs.apps.browsers.enable {
    environment.systemPackages = with pkgs; [
      # google-chrome   # Google Chrome 浏览器
    ];
  };
}
