{ config, lib, pkgs, ... }:

{
  imports = [
    ./qutebrowser-config.nix
  ];
  
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.qutebrowser.enable && config.myHome.dotfiles.qutebrowser.method == "direct") {
    
    home.packages = with pkgs; [
      qutebrowser
    ];
    '';
    
    home.file.".config/qutebrowser/quickmarks".text = ''
    '';
    
  };
}
