{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "direct") {

    home.packages = with pkgs; [ lazygit ];

    home.file.".config/lazygit/config.yml".text = ''
    '';
  };
}
