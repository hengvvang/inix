{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myPkgs.apps.browsers.enable {
    environment.systemPackages = with pkgs; [
      # google-chrome   # Google Chrome 浏览器
    ];
  };
}
