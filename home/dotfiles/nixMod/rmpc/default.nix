{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "homemanager") {
    home.packages = with pkgs; [
      rmpc
    ];
  };
}
