{ config, lib, pkgs, ... }:

let
  cfg = config.myHome.dotfiles.rmpc;
in
{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "external") {

    home.packages = with pkgs; [ rmpc ];
    
    home.file.".config/rmpc/config.ron" = {
      source = ./configs/config.ron;
      executable = false;
    };
    
    home.file.".config/rmpc/themes/rose-pine.ron" =  {
        source = ./configs/themes/rose-pine.ron;
        executable = false;
    };
    
    home.file.".config/rmpc/themes/rose-pine-dawn.ron" =  {
        source = ./configs/themes/rose-pine-dawn.ron;
        executable = false;
    };
    
    home.file.".config/rmpc/themes/rose-pine-moon.ron" =  {
        source = ./configs/themes/rose-pine-moon.ron;
        executable = false;
    };
  };
}
