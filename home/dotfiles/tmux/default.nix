{ config, lib, pkgs, ... }:

{
  options.myHome.dotfiles.tmux = {
    enable = lib.mkEnableOption "Enable tmux configuration";
    method = lib.mkOption {
      type = lib.types.enum [ "homemanager" "direct" "external" "xdirect" ];
      default = "homemanager";
      description = "Method to manage tmux configuration";
    };
  };

  imports = [
    ./homemanager
    ./direct
    ./external
    ./xdirect
  ];
}
