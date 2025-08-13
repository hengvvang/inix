{ config, lib, pkgs, ... }:

{
    config = lib.mkIf config.myHome.pkgs.workflows.enable {
        home.packages = [

            # pkgs.vim
            pkgs.zed-editor
            pkgs.vscode

            # pkgs.git
            # pkgs.rio
            # pkgs.zellij
            # pkgs.rmpc
            # pkgs.yazi
            # pkgs.ghostty
            pkgs.calcure
            pkgs.flameshot
            pkgs.satty

            pkgs.mise
            pkgs.just
            pkgs.devenv

            # pkgs.fish
            # pkgs.nushell
            # pkgs.super-productivity
            # raycast-linux
        ];
    };
}
