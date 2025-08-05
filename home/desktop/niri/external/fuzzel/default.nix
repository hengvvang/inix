{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {

    home.packages = with pkgs; [
      fuzzel
    ];

    fonts.packages = with pkgs; [ lxgw-wenkai ]; # 霞鹜文楷 字体支持

    # Fuzzel 启动器配置
    # 可选主题：
    # - ./fuzzel.ini
    # - ./fuzzel-glass.ini
    # - ./fuzzel-glass-light.ini

    xdg.configFile."fuzzel/fuzzel.ini".source = ./fuzzel-glass.ini;

  };
}
