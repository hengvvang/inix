{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "xdirect") {

    home.packages = with pkgs; [ rofi ];

    home.file.".config/rofi/config.rasi".text = builtins.readFile ./configs/config.rasi;
    home.file.".config/rofi/themes".source = ./configs/themes;
  };
}
