{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {

    home.packages = with pkgs; [ git ];

    home.file.".gitconfig".text = ''
    '';
  };
}
