{ config, lib, pkgs, ... }:

{
  imports = [
    ./vim.nix
    ./micro.nix
    ./zed.nix
    ./vscode.nix
  ];
}
