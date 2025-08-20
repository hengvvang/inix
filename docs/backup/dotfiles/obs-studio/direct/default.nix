{ config, lib, pkgs, ... }:

{
  imports = [
    ./obs-config.nix
  ];

  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.obs-studio.enable && config.myHome.dotfiles.obs-studio.method == "direct") {
    home.packages = lib.optionals config.myHome.dotfiles.obs-studio.packageEnable (with pkgs; [
      obs-studio
    ]);
    home.file.".config/obs-studio/global.ini".text = ''
      [General]
      FirstRun=false
    '';
  };
}
