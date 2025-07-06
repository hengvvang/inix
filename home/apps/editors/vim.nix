{ config, lib, pkgs, ... }:

{
  config = lib.mkIf config.myHome.apps.editors.vim.enable {
    home.packages = with pkgs; [
      vim
    ];
  };
}