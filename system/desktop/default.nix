{ config, lib, pkgs, ... }:

{
  options.mySystem.desktop = {
    enable = lib.mkEnableOption "桌面环境支持";
    
    preset = lib.mkOption {
      type = lib.types.enum [ "gnome" "plasma" "cosmic" ];
      default = "gnome";
      description = ''
        桌面环境预设配置:
        - gnome: GNOME 桌面环境，简洁现代的用户体验
        - plasma: KDE Plasma 桌面环境，功能丰富可定制性强
        - cosmic: COSMIC 桌面环境，System76 开发的现代桌面
      '';
    };
  };

  imports = [
    ./cosmic.nix
    ./gnome.nix
    ./plasma.nix
  ];
}