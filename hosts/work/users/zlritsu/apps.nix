{config, lib, pkgs, inputs, ...}:

{
  home.packages = [
    pkgs.firefox
    pkgs.vscode
  ];
}
