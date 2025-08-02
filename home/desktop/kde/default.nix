{ config, lib, pkgs, ... }:

{
    # options.myHome.desktop.kde = {
    #     themes.enable = lib.mkEnableOption "主题配置";
    #     icons.enable = lib.mkEnableOption "图标配置";
    # };

    config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.preset == "kde") {

        # KDE 主题配置
        # home.file.".themes" = lib.mkIf config.myHome.desktop.kde.themes.enable {
        #     source = ./assets/themes;
        #     executable = false;
        # };

        # KDE 图标配置
        # home.file.".icons" = lib.mkIf config.myHome.desktop.kde.icons.enable {
        #     source = ./assets/icons;
        #     executable = false;
        # };

        home.packages = with pkgs; [
        # ---- kde packages ----
            kdePackages.discover
            kdePackages.kcalc
            kdePackages.kcharselect
            kdePackages.kcolorchooser
            kdePackages.kolourpaint
            kdePackages.ksystemlog
            kdePackages.sddm-kcm
            kdiff3
            hardinfo2
            haruna
            xclip
        ];
    };
}