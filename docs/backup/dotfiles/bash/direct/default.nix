{ config, lib, pkgs, ... }:

{
  imports = [
    ./.bashrc.nix
    ./.bash_profile.nix
    ./.bash_aliases.nix
    ./.bash_functions.nix
    ./.bash_profile.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.bash.enable && config.myHome.dotfiles.bash.method == "direct") {

    home.packages = lib.optionals config.myHome.dotfiles.bash.packageEnable (with pkgs; [ bash ]);
  };
}
