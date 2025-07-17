# 🌖 亏凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningGibbous.enable {
    home.packages = with pkgs; [

      fish   
      nushell

      tmux
      
      git

      nano
      vim  
      vscode
      zed-editor
      
      yazi

      
    ];
  };
}
