
{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri"&& config.myHome.desktop.niri.appearance.enable && config.myHome.desktop.niri.appearance.method == "homeManager") {
    # ========== GTK 配置 ==========
    gtk = {
      enable = true;

      theme = {
        name = lib.mkForce "WhiteSur-Light";
        package = lib.mkForce pkgs.whitesur-gtk-theme;
      };

      iconTheme = {
        name = lib.mkForce "WhiteSur";
        package = lib.mkForce pkgs.whitesur-icon-theme;
      };

      cursorTheme = {
        name = lib.mkForce "macOS";
        package = lib.mkForce pkgs.apple-cursor;
        size = lib.mkForce 24;
      };

      font = {
        name = lib.mkForce "LXGW WenKai";
        size = lib.mkForce 11;
      };
    };
  };
}
