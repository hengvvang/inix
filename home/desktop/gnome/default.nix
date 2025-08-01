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
            # GNOME 核心应用
            gnome.gnome-tweaks
            gnome.dconf-editor
            
            # GNOME 扩展
            gnomeExtensions.user-themes
            gnomeExtensions.dash-to-dock
            gnomeExtensions.appindicator
            gnomeExtensions.blur-my-shell
            gnomeExtensions.hide-activities-button
            gnomeExtensions.just-perfection
            gnomeExtensions.tray-icons-reloaded
            gnomeExtensions.quick-settings-tweaker
            gnomeExtensions.removable-drive-menu
            gnomeExtensions.vitals
            gnomeExtensions.gtile
            gnomeExtensions.space-bar
            
            # 主题相关
            adwaita-icon-theme
            orchis-theme
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
