{ config, lib, pkgs, ... }:

{
  imports = [
    ./gtk.nix
    ./qt.nix
  ];

  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

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
      XCURSOR_THEME = "macOS";
      XCURSOR_SIZE = "24";
    };
  };
}
