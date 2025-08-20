{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rmpc.enable && config.myHome.dotfiles.rmpc.method == "external") {
    home.packages = lib.optionals config.myHome.dotfiles.rmpc.packageEnable (with pkgs; [
      rmpc
    ]);

    home.file.".config/rmpc/config.toml".source = ./configs/config.toml;
  };
}
