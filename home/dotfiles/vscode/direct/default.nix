{ config, lib, pkgs, ... }:

{
  imports = [
    ./settings.nix
    ./extensions.nix
  ];
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.vscode.enable && config.myHome.dotfiles.vscode.method == "direct") {
    home.packages = with pkgs; [
      vscode
    ];
  };
}
