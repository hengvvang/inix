{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "external") {
    
    home.packages = with pkgs; [ nushell ];
    
    home.file.".config/nushell/config.nu".source = ./configs/config.nu;
    home.file.".config/nushell/env.nu".source = ./configs/env.nu;
  };
}
