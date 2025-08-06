{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "xdirect") {
    home.packages = with pkgs; [
      rmpc
    ];

    home.file.".config/rmpc/config.toml".text = builtins.readFile ./configs/config.toml;
  };
}
