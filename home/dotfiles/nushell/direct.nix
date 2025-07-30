{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "direct") {
    
    home.packages = with pkgs; [ nushell ];
    
    home.file.".config/nushell/config.nu".text = ''
    '';
    
    home.file.".config/nushell/env.nu".text = ''
    '';
  };
}
