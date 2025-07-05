{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors = {
    vim = lib.mkEnableOption "Vim 编辑器配置";
    vscode = lib.mkEnableOption "VSCode 编辑器配置";
    micro = lib.mkEnableOption "Micro 编辑器配置";
    zed = lib.mkEnableOption "Zed 编辑器配置";
  };

  imports = [
    ./vim.nix
    ./micro.nix
    ./zed.nix
    ./vscode.nix
  ];
}
