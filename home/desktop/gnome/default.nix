{ config, lib, pkgs, ... }:

{
    options.myHome.desktop.gnome = {
        themes.enable = lib.mkEnableOption "主题配置";
        icons.enable = lib.mkEnableOption "图标配置";
    };

    config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "gnome") {
        
        # GNOME 主题配置
        home.file.".themes" = lib.mkIf config.myHome.desktop.gnome.themes.enable {
            source = ./assets/themes;
            executable = false;
        };

        # GNOME 图标配置  
        home.file.".icons" = lib.mkIf config.myHome.desktop.gnome.icons.enable {
            source = ./assets/icons;
            executable = false;
        };

        # GNOME 桌面环境包
        home.packages = with pkgs; [

            # tiling window manager
            pkgs.gnomeExtensions.tiling-shell
            # pkgs.gnomeExtensions.forge     # tiling-shell 的替代品
            pkgs.gnomeExtensions.tiling-assistant

            # scrollable-tiling
            #pkgs.gnomeExtensions.paperwm

            pkgs.gnomeExtensions.fuzzy-app-search
            pkgs.gnomeExtensions.applications-menu
            pkgs.gnomeExtensions.user-themes
            pkgs.gnomeExtensions.blur-my-shell
            pkgs.gnomeExtensions.extension-list
            pkgs.gnomeExtensions.dash-to-dock
            pkgs.gnomeExtensions.logo-menu
            pkgs.gnomeExtensions.clipboard-indicator
            pkgs.gnomeExtensions.caffeine
            pkgs.gnomeExtensions.kimpanel # fcitx need; recommand extension: Fcitx HUD
        ];

        # GNOME 设置
        dconf.settings = {
            "org/gnome/desktop/interface" = {
                gtk-theme = "Adwaita";
                icon-theme = "Adwaita";
                cursor-theme = "Adwaita";
            };
        };
    };
}
