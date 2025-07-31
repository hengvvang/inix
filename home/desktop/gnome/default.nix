# { config, lib, pkgs, ... }:

# {
#     options.myHome.desktop.gnome = {
#         enable = lib.mkEnableOption "Gnome 桌面环境配置";
#         themes.enable = lib.mkEnableOption "主题配置";
#         icons.enable = lib.mkEnableOption "图标配置";
#     };

#     config = lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.gnome.enable && config.myHome.desktop.gnome.themes.enable) {
        
#         home.file.".themes" = {
#         source = ./assets/themes;
#         executable = false;
#         };
#         home.file.".icons" = {
#         source = ./assets/icons;
#         executable = false;
#         };
#     };
# }

{ config, lib, pkgs, ... }:

{
    options.myHome.desktop.gnome = {
        enable = lib.mkEnableOption "Gnome 桌面环境配置";
        themes.enable = lib.mkEnableOption "主题配置";
        icons.enable = lib.mkEnableOption "图标配置";
    };

    config = lib.mkMerge [
        (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.gnome.enable && config.myHome.desktop.gnome.themes.enable ){
            home.file.".themes" = {
            source = ./assets/themes;
            executable = false;
            };
        })

        (lib.mkIf (config.myHome.desktop.enable && config.myHome.desktop.gnome.enable && config.myHome.desktop.gnome.icons.enable) {
            home.file.".icons" = {
            source = ./assets/icons;
            executable = false;
            };
        })
    ];
}
