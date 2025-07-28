{ config, lib, pkgs, ... }:

{
  # Flatpak 配置选项
  options.mySystem.services.containers.flatpak = {
    enable = lib.mkEnableOption "Flatpak 应用容器";
    
    flathub = lib.mkEnableOption "Flathub 应用商店" // { default = true; };
    
    fonts = lib.mkEnableOption "字体支持" // { default = true; };
    
    themes = lib.mkEnableOption "主题支持" // { default = true; };
    
    xdgPortal = lib.mkEnableOption "XDG 门户支持" // { default = true; };
    
    remotes = lib.mkOption {
      type = lib.types.listOf (lib.types.submodule {
        options = {
          name = lib.mkOption {
            type = lib.types.str;
            description = "远程仓库名称";
          };
          url = lib.mkOption {
            type = lib.types.str;
            description = "远程仓库URL";
          };
        };
      });
      default = [];
      description = "额外的 Flatpak 远程仓库";
    };
  };

  imports = [
    ./flatpak.nix
  ];
}
