{ config, lib, pkgs, ... }:

{
  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./kde.nix
    ./hyprland.nix
    ./niri.nix
  ];

  options.mySystem.desktop = {
    enable = lib.mkEnableOption "桌面环境支持";
    preset = lib.mkOption {
      type = lib.types.enum [ "gnome" "kde" "cosmic" "hyprland" "niri"];
      default = "gnome";
      description = ''
        桌面环境预设配置:
        - gnome: GNOME 桌面环境，简洁现代的用户体验
        - kde: KDE 桌面环境，功能丰富可定制性强
        - cosmic: COSMIC 桌面环境, System76 开发的现代桌面
        - hyprland: Hyprland, 基于 Wayland 的动态平铺窗口管理器
        - niri: Niri 桌面环境，专注于简洁和效率
      '';
    };
  };
}
