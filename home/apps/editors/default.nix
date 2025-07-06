{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors = {
    vim.enable = lib.mkEnableOption "Vim 编辑器配置";
    vscode.enable = lib.mkEnableOption "VSCode 编辑器配置";
    micro.enable = lib.mkEnableOption "Micro 编辑器配置";
    zed.enable = lib.mkEnableOption "Zed 编辑器配置";
  };

  imports = [
    ./vim.nix
    ./micro.nix
    ./zed.nix
    ./vscode.nix
  ];
}
