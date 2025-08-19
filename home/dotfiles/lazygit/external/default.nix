{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.lazygit.enable && config.myHome.dotfiles.lazygit.method == "external") {

    home.packages = lib.optionals config.myHome.dotfiles.lazygit.packageEnable (with pkgs; [ lazygit ]);

    home.file.".config/lazygit/config.yml".source = ./configs/config.yml;
  };
}
