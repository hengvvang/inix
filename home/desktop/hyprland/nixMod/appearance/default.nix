{ config, lib, pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "hyprland" && config.myHome.desktop.hyprland.appearance.enable && config.myHome.desktop.hyprland.appearance.configStyle == "homeManager") {

    # ========== macOS 风格主题包 ==========
    home.packages = with pkgs; [
      whitesur-gtk-theme
      whitesur-icon-theme
      apple-cursor
      lxgw-wenkai
    ];

    # ========== 鼠标光标配置 ==========
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      name = "macOS";
      package = pkgs.apple-cursor;
      size = 24;
    };

    # ========== 字体配置 ==========
    fonts.fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "LXGW WenKai" ];
        serif = [ "LXGW WenKai" ];
        monospace = [ "LXGW WenKai Mono" ];
      };
    };

    # ========== 环境变量 ==========
    # 光标主题相关环境变量保留，因为某些应用可能需要
    home.sessionVariables = {
      # ========== Xwayland 应用缩放设置 ==========
      # GTK 应用缩放
      GDK_SCALE = "1.00";
      GDK_DPI_SCALE = "1.0";

      # Qt 应用缩放
      QT_SCALE_FACTOR = "1.00";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_FONT_DPI = "144";
    };
  };
}
