{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rio.enable && config.myHome.dotfiles.rio.method == "xdirect") {

    home.packages = lib.optionals config.myHome.dotfiles.rio.packageEnable (with pkgs; [ rio ]);

    home.file.".config/rio/config.toml".text = builtins.readFile ./configs/config.toml;
  };
}
