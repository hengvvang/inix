{ config, lib, pkgs, ... }:

{
  imports = [
    ./starship.toml.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.starship.enable && config.myHome.dotfiles.starship.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.starship.packageEnable (with pkgs; [ starship ]);
  };
}
