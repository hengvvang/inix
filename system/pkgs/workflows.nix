{ config, lib, pkgs, ... }:

{
    config = lib.mkIf config.mySystem.pkgs.workflows.enable {
        environment.systemPackages = [
          pkgs.vim
          pkgs.zed-editor
          # pkgs.vscode

          pkgs.git
          pkgs.rio
          pkgs.zellij
          pkgs.rmpc
          pkgs.yazi

          pkgs.mise
          pkgs.just
          pkgs.devenv
        ];
    };
}
