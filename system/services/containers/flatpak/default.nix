{ config, lib, pkgs, ... }:

{
  imports = [
    ./flatpak.nix
  ];
  # Flatpak 配置选项
  options.mySystem.services.containers.flatpak = {
    enable = lib.mkEnableOption "Flatpak 应用容器";

    xdgPortal.enable = lib.mkEnableOption "XDG 门户支持" // { default = true; };

    flathub.enable = lib.mkEnableOption "Flathub 应用商店" // { default = true; };

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
}
