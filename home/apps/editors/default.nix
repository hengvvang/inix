{ config, lib, pkgs, ... }:

{
  options.myHome.apps.editors.enable = lib.mkEnableOption "编辑器配置";

  config = lib.mkIf config.myHome.apps.editors.enable {
    
  };

  imports = [
    ./vim.nix
    ./micro.nix
    ./zed.nix
    ./vscode.nix
  ];
}
