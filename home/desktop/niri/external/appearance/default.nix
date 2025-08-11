{ config, lib, pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    # ========== macOS 风格主题包 ==========
    home.packages = with pkgs; [
      whitesur-gtk-theme       # macOS 风格 GTK 主题
      whitesur-icon-theme      # macOS 风格图标主题
      apple-cursor             # macOS 光标主题
      lxgw-wenkai              # 霞鹜文楷字体
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
    home.sessionVariables = {
      # GTK 主题
      GTK_THEME = "WhiteSur-Light";

      # Qt 主题
      QT_QPA_PLATFORMTHEME = "gtk3";
      QT_STYLE_OVERRIDE = "gtk3";

      # 光标主题
      XCURSOR_THEME = "macOS";
      XCURSOR_SIZE = "24";
    };
  };
}
