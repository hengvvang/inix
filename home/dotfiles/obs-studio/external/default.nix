{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "external") {
    home.packages = lib.optionals config.myHome.dotfiles.obs-studio.packageEnable (with pkgs; [
      obs-studio
    ]);

    home.file.".config/obs-studio/global.ini".source = ./configs/global.ini;
  };
}
