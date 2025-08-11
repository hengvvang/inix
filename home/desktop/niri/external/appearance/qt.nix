{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri" && config.myHome.desktop.niri.method == "external") {
    # ========== Qt 配置 ==========
    qt = {
      enable = true;
      platformTheme.name = "gtk3";
      style = {
        name = "gtk3";
      };
    };
  };
}
