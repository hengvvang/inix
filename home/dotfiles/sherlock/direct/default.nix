# Sherlock Launcher - Direct Configuration Mode
{ config, lib, pkgs, ... }:

{
  imports = [
    ./config.nix
    ./theme.nix
    ./aliases.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.sherlock.packageEnable (with pkgs; [
      sherlock-launcher
    ]);
  };
}
