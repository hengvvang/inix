{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.browsers.enable {
    home.packages = with pkgs; [
      # google-chrome   # Google Chrome 浏览器
    ];
  };
}
