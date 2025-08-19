{ config, lib, pkgs, ... }:

{
  imports = [
    ./rmpc-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.rmpc.packageEnable (with pkgs; [
      rmpc
    ]);
  };
}
