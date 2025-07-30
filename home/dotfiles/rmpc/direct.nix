{ config, lib, pkgs, ... }:

let
    cfg = config.myHome.dotfiles.rmpc;
in
{
    config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "direct") {

        home.packages = with pkgs; [ rmpc ];
        
        home.file.".config/rmpc/config.ron".text = ''
        '';

        home.file.".config/rmpc/themes/rose-pine.ron".text = ''
        '';       
        home.file.".config/rmpc/themes/rose-pine-dawn.ron".text = ''
        '';
        home.file.".config/rmpc/themes/rose-pine-moon.ron".text = ''
        '';
        home.file.".config/rmpc/themes/rose-pine-darcula.ron".text = ''
        '';
        home.file.".config/rmpc/themes/tokyo-night.ron".text = ''
        '';
    };
}
