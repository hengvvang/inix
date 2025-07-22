{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zsh.enable && config.myHome.dotfiles.zsh.method == "external") {
    
    home.packages = with pkgs; [ zsh ];
    
    home.file.".zshrc".source = ./configs/zshrc;
  };
}
