{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "niri"&& config.myHome.desktop.niri.appearance.enable && config.myHome.desktop.niri.appearance.method == "homemanager") {
    # ========== Qt 配置 ==========
    qt = {
      enable = true;

      # 使用新的 platformTheme 配置选项
      platformTheme = {
        name = "gtk3";
      };

      # Qt 样式配置
      style = {
        name = "gtk2";  # 使用gtk2样式以更好地与macOS主题兼容
      };
    };
  };
}
