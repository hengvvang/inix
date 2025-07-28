# 🌖 亏凸月

{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.pkgs.apps.waningGibbous.enable {
    home.packages = with pkgs; [

      git

      # vim 已通过 programs.vim 配置，避免重复
      vscode
      zed-editor

      fish   
      nushell

      rio
      yazi
      zellij

      rmpc

      # raycast-linux
      # tmux
      
    ];
  };
}
