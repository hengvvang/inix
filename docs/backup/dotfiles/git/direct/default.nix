{ config, lib, pkgs, ... }:

{
  imports = [
    ./gitconfig.nix
    ./gitignore.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.git.enable && config.myHome.dotfiles.git.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.git.packageEnable (with pkgs; [ git ]);
  };
}
