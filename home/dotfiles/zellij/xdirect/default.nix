{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zellij.enable && config.myHome.dotfiles.zellij.method == "xdirect") {

    home.packages = with pkgs; [ zellij ];

    home.file.".config/zellij/config.kdl".text = builtins.readFile ./configs/config.kdl;
    home.file.".config/zellij/layouts".source = ./configs/layouts;
  };
}
