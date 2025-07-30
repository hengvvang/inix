{ config, lib, pkgs, ... }:

{
  config = lib.mkIf (config.myHome.dotfiles.enable && config.myHome.dotfiles.rofi.enable && config.myHome.dotfiles.rofi.method == "direct") {
    
    home.packages = with pkgs; [ rofi ];

    home.file.".config/rofi/config.rasi".text = ''
    '';

    home.file.".local/bin/rofi-launcher".text = ''
    '';

    home.file.".local/bin/rofi-launcher" = {
      executable = true;
    };
  };
}
