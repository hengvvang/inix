{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "xdirect") {
    home.packages = with pkgs; [
      obs-studio
    ];

    home.file.".config/obs-studio/global.ini".text = builtins.readFile ./configs/global.ini;
  };
}
