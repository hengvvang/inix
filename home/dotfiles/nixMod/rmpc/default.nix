{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.homeManager.enable) {
    home.packages = with pkgs; [
      rmpc
    ];
  };
}
