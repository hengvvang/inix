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

        home.packages = [
            
            # scrollable-tiling window manager
            pkgs.kdePackages.karousel

            pkgs.kdePackages.discover
            pkgs.kdePackages.kcalc
            pkgs.kdePackages.kcharselect
            pkgs.kdePackages.kcolorchooser
            pkgs.kdePackages.kolourpaint
            pkgs.kdePackages.ksystemlog
            pkgs.kdePackages.sddm-kcm

            pkgs.kdiff3
            pkgs.hardinfo2
            pkgs.haruna
            pkgs.xclip
        ];
    };
}