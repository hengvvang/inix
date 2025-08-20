{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.ghostty.enable && config.myHome.dotfiles.ghostty.method == "xdirect") {

    home.packages = lib.optionals config.myHome.dotfiles.ghostty.packageEnable (with pkgs; [ ghostty ]);

    home.file.".config/ghostty/config".text = builtins.readFile ./configs/config;
  };
}
