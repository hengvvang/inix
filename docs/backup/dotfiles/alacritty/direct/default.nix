{ config, lib, pkgs, ... }:

{
  imports = [
    ./alacritty.toml.nix
    ./themes.toml.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.alacritty.enable &&
                    config.myHome.dotfiles.alacritty.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.alacritty.packageEnable (with pkgs; [ alacritty ]);
  };
}
