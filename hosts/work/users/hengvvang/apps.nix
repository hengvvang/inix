{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    pkgs.google-chrome
    pkgs.firefox

    pkgs.zed-editor
    pkgs.vscode
  ];
}
