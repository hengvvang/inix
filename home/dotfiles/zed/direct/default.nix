{ config, lib, pkgs, ... }:

{
  imports = [
    ./settings.json.nix
    ./extensions.json.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.zed.enable && config.myHome.dotfiles.zed.method == "direct") {

    home.packages = with pkgs; [ zed-editor ];
  };
}
