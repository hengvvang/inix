{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.editors.zed.enable {
  home.packages = with pkgs; [
    zed-editor
  ];
  };
}