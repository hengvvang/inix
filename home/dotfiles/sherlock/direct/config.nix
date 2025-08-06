{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.sherlock.enable && config.myHome.dotfiles.sherlock.method == "direct") {
    home.file.".config/sherlock/config.toml".text = ''
      # Sherlock Configuration - Direct Mode
      [config]
      width = 800
      height = 600
      gsk_renderer = "cairo"
      opacity = 0.95

      [config.behavior]
      animate = true

      [config.binds]
      modifier = "super"

      [config.backdrop]
      enable = true
      opacity = 0.8

      [config.expand]
      enable = true
      margin = 40

      [config.runtime]
      center = true

      [config.default_apps]
      terminal = "ghostty"
      browser = "firefox"
    '';
  };
}
