{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "direct") {
    
    home.packages = with pkgs; [ rio ];
    
    home.file.".config/rio/config.toml".text = ''
    '';
    
    programs.fish.shellInit = lib.mkIf config.programs.fish.enable ''
    '';
  };
}
