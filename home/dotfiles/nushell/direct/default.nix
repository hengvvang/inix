{ config, lib, pkgs, ... }:

{
  imports = [
    ./nushell-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.nushell.enable && config.myHome.dotfiles.nushell.method == "direct") {

    home.packages = lib.optionals config.myHome.dotfiles.nushell.packageEnable (with pkgs; [ nushell ]);
  };
}
