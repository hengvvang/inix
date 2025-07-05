{ config, lib, pkgs, ... }:

{
  imports = [
    ./vim
    ./micro
    ./zed.nix
    ./vscode.nix
  ];
}
